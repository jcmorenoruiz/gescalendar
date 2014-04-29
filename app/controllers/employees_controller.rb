class EmployeesController < ApplicationController
  
before_action :signed_in_user
before_action :correct_user, only: [:edit, :update, :show]
before_action :admin_user, only: [:destroy,:index]

	def show
		@emp=Employee.find(params[:id])
	end

    

  	def new
  	@emp=Employee.new
    @departments=Enterprise.find(current_emp).departments
  	end

  	def create
   		@emp=Employee.new(employee_params)
      @departments=Enterprise.find(current_emp).departments
   		
      if(@emp.save)
   			flash[:success] = "Empleado dado de alta correctamente"
   			redirect_to employees_url
   		else
   			render 'new'
   		end
   	end 

    def index

      @dptos=Department.where(enterprise_id: current_emp.id) # departments from enterprise
      @employees=Employee.where(department_id: @dptos)
      # filters
      @employees=@employees.filter(params.slice(:status,:department,:starts_with))
      # paginate
      @employees=@employees.paginate(page: params[:page]) # employes on departments
    
    end
  
    def edit    
    end

    def update
     
      if @emp.update_attributes(employee_params)
          flash[:success] = "Perfil actualizado correctamente"
          redirect_to @emp
      else
        render 'edit'
      end
    end


    def destroy
      if Employee.find(params[:id]).update_attribute(:status, 0)
        flash[:success]="Empleado dado de baja correctamente"
      end
       redirect_to employees_url
    end

  
   	private

   	def employee_params
   		params.require(:employee).permit(:nombre,:email,:password,
   			:password_confirmation,:department_id, :role, :cargo, :fecha_alta, :fecha_baja)
   	end

    # before filers
    
    def correct_user
      @emp=Employee.find(params[:id])
      redirect_to(root_url) unless current_user?(@emp) || current_user.role>2
    end

   
end
