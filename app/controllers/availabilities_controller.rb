class AvailabilitiesController < ApplicationController

	before_action :set_availability, only: [:edit, :update, :destroy, :show]
  before_action :signed_in_user
  before_action :admin_user
  before_action :correct_availability, only: [:edit,:create,:update,:destroy]
  

	def new 
			@dpto=Department.find(params[:id])
			@av=Availability.new
	end

	def create
		@dpto = Department.find(params[:availability][:department_id])
    @av = @dpto.availabilities.build(availabilities_params)

    if @av.save
        flash[:success]= 'Disponibilidad agregada correctamente al Departamento'
        redirect_to department_path(@dpto)
    else
        render "new" 
    end
	end



	def edit
		@av=Availability.find(params[:id])
		@dpto=Department.find(@av.department_id)
	end

	def update
		@dpto=Department.find(@av.department_id)
		if @av.update(availabilities_params)
        flash[:success] = "Disponibilidad mínima registrada correctamente"
        redirect_to department_path(@av.department_id)
    else
        render 'edit'
    end
	end 

	def destroy
		  if @av.destroy
        flash[:success]= 'Disponibilidad eliminada correctamente'
        redirect_to department_path(@av.department_id)
    	end
	end



	private


	def availabilities_params
		  params.require(:availability).permit(:cargo, :num_min_emp, :desde,:hasta,:notas, :department_id)
	end

	  def set_availability
      @av = Availability.find(params[:id])
    end


   def correct_availability
      if(!@av.nil?)
        @avcheck=Department.find(@av.department_id)
      else
        @avcheck=Department.find(params[:availability][:department_id])
      end
      redirect_to(departments_url) unless current_emp.id==@avcheck.enterprise_id || current_user.role>3      
   end

end
