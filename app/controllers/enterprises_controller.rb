class EnterprisesController < ApplicationController

before_action :signed_in_user, only: [:index,:edit,:update,:show] # => empleados
before_action :admin_user, only: [:show,:edit,:update]  # => admin
before_action :correct_emp,  only: [:show,:edit,:update]  # => superadmin

  def edit
      @emp=Enterprise.find(params[:id])
  end

  def update
    @emp=Enterprise.find(params[:id])
     if @emp.update_attributes(enterprise_params)
            flash[:success] = "Empresa actualizada correctamente"
            redirect_to current_user
        else
          render 'edit'
        end
  end

  def show
  end

  def index
  end

  def new
  	@enterprise = Enterprise.new
    department=@enterprise.departments.build
    department.employees.build
  end

  def create 

    @enterprise=Enterprise.new(enterprise_params)
    @enterprise.departments[0].employees[0].role=3
    @enterprise.notif_solicitudes=1
    @enterprise.notif_auditoria=1
    @enterprise.notif_apertura=1
    @enterprise.status=1
   	
    if @enterprise.save         	
        sign_in @enterprise.departments[0].employees[0]
   			flash[:success] = "Bienvenido a su Calendario"
   			redirect_to @enterprise.departments[0].employees[0]
   	else
   			render 'new'
   	end
  end 
   


   	private

     def enterprise_params
      params.require(:enterprise).permit(:empresa,
        departments_attributes:[:nombre,:enterprise_id,
          employees_attributes: [:nombre, :email, :password, :password_confirmation,
          	:fecha_alta]
          ])
    end

    # before filers

    # Evitar acceso a informacion de otras empresas. Salvo si es superadmin.
    def correct_emp
      @emp=Enterprise.find(params[:id])
      redirect_to(current_emp) unless current_emp.id==@emp.id || current_user.role>3
    end

end
