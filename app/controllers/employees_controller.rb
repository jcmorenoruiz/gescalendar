class EmployeesController < ApplicationController
  
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

  
   	private

   	def employee_params
   		params.require(:employee).permit(:name,:email,:password,
   			:password_confirmation)
   	end
end
