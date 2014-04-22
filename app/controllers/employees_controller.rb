class EmployeesController < ApplicationController
  
before_action :signed_in_user, only: [:index,:edit,:update,:show, :destroy]
before_action :correct_user, only: [:edit, :update, :show]
before_action :admin_user, only: [:destroy,:index]

	def show
		@emp=Employee.find(params[:id])
	end
  	def new
  	@emp=Employee.new
  	end

  	def create
   		@emp=Employee.new(employee_params)

   		if(@emp.save)
        sign_in @emp
   			flash[:success] = "Bienvenido a su Calendario"
   			redirect_to @emp
   		else
   			render 'new'
   		end
   	end 

    def index
      @employees=Employee.paginate(page: params[:page])
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
      Employee.find(params[:id]).destroy
      flash[:success]="Empleado eliminado correctamente"
      redirect_to employees_url

    end

   	private

   	def employee_params
   		params.require(:employee).permit(:name,:email,:password,
   			:password_confirmation)
   	end

    # before filers

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Por favor, identifiquese!" 
      end
    end

    def correct_user
      @emp=Employee.find(params[:id])
      redirect_to(root_url) unless current_user?(@emp)
    end

    def admin_user
      redirect_to(root_url) unless current_user.role==3
    end
end
