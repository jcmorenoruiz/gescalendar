class DepartmentsController < ApplicationController

	before_action :signed_in_user
	before_action :admin_user, except: [:show]
	before_action :correct_department , only: [:edit, :update, :show]
	
	# common actions

	# departamentos de la empresa cuyo usuario esta autentificado
	def index
		 @departments=Department.where(enterprise_id: current_emp.id)
		 # filters
      	 @departments=@departments.filter(params.slice(:status))	
      	 # paginate
      	 #@departments=@departments.paginate(page: params[:page]) # employes on departments
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
      	if(@dpto.status)
      		@dpto.update_attribute(:status,0)
      		flash[:success]="Departamento dado de baja correctamente"  	
      	else 
      		@dpto.update_attribute(:status,1)
      		flash[:success]="Departamento reactivado correctamente"  	
      	end
      end 
      redirect_to departments_url
    end

    # private methods
    private
     	def department_params
   		params.require(:department).permit(:nombre,:jefe_auditor,
   			availabilities_attributes: [:num_min_emp,:notas,:desde,:hasta,:cargo],
   		  :request_type_ids => [],
   		  :request_type_num_max_dias => []
   			)

   		end

   	
      # before filers

    	def correct_department
      		@dpto=Department.find(params[:id]) 
      		unless (chief_user? && current_user.department_id==@dpto.id) || (admin_user? && current_emp.id==@dpto.enterprise_id) || current_user.role>3
            flash[:danger] = 'ERROR. No tiene acceso al recurso solicitado.'
            redirect_to(departments_url)
          end
    	end



   
end
