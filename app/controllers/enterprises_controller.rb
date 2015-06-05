class EnterprisesController < ApplicationController

before_action :signed_in_user, only: [:index,:edit,:update,:show] # => empleados
before_action :admin_user, only: [:show,:edit,:update]  # => admin
before_action :correct_emp,  only: [:show,:edit,:update]  # => superadmin

  def edit
      @countries=Enterprise.new.countries
      @emp=Enterprise.find(params[:id])
  end

  def update
    @emp=Enterprise.find(params[:id])
     if @emp.update_attributes(enterprise_params)
            flash[:success] = "Empresa actualizada correctamente"
            redirect_to edit_enterprise_path(current_emp.id)
        else
          render 'edit'
        end
  end

  def new
    @countries=Enterprise.new.countries
  	@enterprise = Enterprise.new
    department=@enterprise.departments.build
    department.employees.build
  end

  def create 
    @countries=Enterprise.new.countries
    @enterprise=Enterprise.new(enterprise_params)
   
    rts=DefaultRequestType.where(:status => true).all
    colors=["#1a6e2b","#5e2913","#de1b28","#faa07a"]
     # assign default request types to enterprise
    rts.each do |line|
      @enterprise.request_types.build(
        :nombre => line.nombre,:num_dias_max => line.num_dias_max,:status => true,:tipo => true,:color => colors.pop)
    end
  
    @enterprise.departments[0].employees[0].role=3
    @enterprise.notif_solicitudes=1
    @enterprise.notif_auditoria=1
    @enterprise.notif_apertura=1
    @enterprise.status=1
   	
    if @enterprise.save        
        # Tell the UserMailer to send a welcome email after save
        UserMailer.welcome_email(@enterprise.departments[0].employees[0]).deliver	
       
        sign_in @enterprise.departments[0].employees[0]
   			flash[:success] = "Bienvenido a su Calendario"
   			redirect_to @enterprise.departments[0].employees[0]
   	else
   			render 'new'
   	end
  end 
   


   	private

    def enterprise_params
      params.require(:enterprise).permit(:empresa,:country,:notif_solicitudes,:notif_auditoria,:notif_apertura,
        departments_attributes:[:nombre,:enterprise_id,
          employees_attributes: [:nombre, :email, :password, :password_confirmation, :cargo,
          	:fecha_alta]
          ])
    end

    # before filers

    # Evitar acceso a informacion de otras empresas. Salvo si es superadmin.
    def correct_emp
      @emp=Enterprise.find(params[:id])
      unless current_emp.id==@emp.id || current_user.role>3
        flash[:danger] = 'ERROR. Acceso no autorizado al recurso solicitado.'
        redirect_to(root_path)
      end
    end

end
