class AvailabilitiesController < ApplicationController

	before_action :set_availability, only: [:edit, :update, :destroy, :show]
  before_action :signed_in_user
  before_action :chief_user
  before_action :correct_availability, only: [:edit,:create,:update,:destroy]

	def new
			@dpto=Department.find(params[:id])
			if chief_user? && current_user.department != @dpto
        flash[:danger] = 'ERROR. No tiene acceso al recurso solicitado.'
        redirect_to departments_url
      end
      @positions = Employee.unscoped.where(:department_id => @dpto.id).order('cargo ASC').select(:cargo).distinct
      @av=Availability.new
	end

	def create
		@dpto = Department.find(params[:availability][:department_id])
    @av = @dpto.availabilities.build(availabilities_params)

    if @av.save
        flash[:success]= 'Disponibilidad mínima agregada correctamente al Departamento'
        redirect_to department_path(@dpto)
    else
         @positions = Employee.unscoped.where(:department_id => @dpto.id).order('cargo ASC').select(:cargo).distinct
        render "new"
    end
	end



	def edit
		@av=Availability.find(params[:id])
		@dpto=Department.find(@av.department_id)
     @positions = Employee.unscoped.where(:department_id => @dpto.id).order('cargo ASC').select(:cargo).distinct
	end

	def update
		@dpto=Department.find(@av.department_id)
		if @av.update(availabilities_params)
        flash[:success] = "Disponibilidad mínima actualizada correctamente"
        redirect_to department_path(@av.department_id)
    else
          @positions = Employee.unscoped.where(:department_id => @dpto.id).order('cargo ASC').select(:cargo).distinct
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
    unless (current_user.department==@avcheck) || (current_emp.id == @avcheck.enterprise_id && current_user.role==3) || current_user.role>3
      flash[:danger] = 'ERROR. No tiene acceso al recurso solicitado.'
      redirect_to(departments_url)
    end
   end

end
