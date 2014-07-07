class DepartmentsController < ApplicationController

	before_action :signed_in_user
	before_action :admin_user
	before_action :correct_department , only: [:edit, :update, :show]
	
	# common actions

	# departamentos de la empresa cuyo usuario esta autentificado
	def index
		 @departments=Department.where(enterprise_id: current_emp.id,status: 't').paginate(page: params[:page]) 	
	end 
	def new
		@dpto=Department.new
		@request_types=RequestType.where(:enterprise_id => current_emp)
	end 


	def edit
		@request_types=RequestType.where(:enterprise_id => current_emp)
		@dpto=Department.find(params[:id])
	end

	def update
		@dpto=Department.find(params[:id])
		 if @dpto.update_attributes(department_params)
          	flash[:success] = "Departamento actualizado correctamente"
          	redirect_to departments_url
      	else
        	render 'edit'
      	end
	end

	def create
		@request_types=RequestType.where(:enterprise_id => current_emp)

		@dpto=Department.new(department_params)
		@dpto.nombre=@dpto.nombre.capitalize
		@dpto.enterprise_id=current_emp.id

		
		if(@dpto.save)
			flash[:success]="Departamento creado correctamente"
			redirect_to departments_url
		else
			render 'new'
		end
	end

	def ausencias 
    @dpto=Department.find(params[:id])
  end
	
	def show
		@dpto=Department.find(params[:id])
	end

	def destroy
      @dpto=Department.find(params[:id])

      if(@dpto.employees.count>0)
      	flash[:error]="No es posible dar de baja un departamento si tiene empleados en activo o de baja"
      else
      	@dpto.update_attribute(:status,0)
      	flash[:success]="Departamento dado de baja correctamente"  	
      end 
      redirect_to departments_url
    end

    # private methods
    private
     	def department_params
   		params.require(:department).permit(:nombre, 
   			availabilities_attributes: [:num_min_emp,:notas,:desde,:hasta,:cargo],
   		  :request_type_ids => [],
   		  :request_type_num_max_dias => []
   			)

   		end

   	
      # before filers

    	def correct_department
      		@emp=Department.find(params[:id]) 
      		redirect_to(departments_url) unless current_emp.id==@emp.enterprise_id || current_user.role>3
    	end



   
end
