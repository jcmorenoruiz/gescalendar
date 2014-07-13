class CalendarsController < ApplicationController
 
  before_action :signed_in_user
  before_action :admin_user
  before_action :correct_calendar , only: [:edit, :update, :show, :destroy] 
  before_action :set_departments , only: [:new,:create,:index]
  #common methods
  def new
    @calendar=Calendar.new
    @years=2.years.ago.year..Time.now.year+1 # years range
    #@dptos=Department.where(enterprise_id: current_emp.id)
  end

 def create
    #@dptos=Department.where(enterprise_id: current_emp.id)
   @calendar=Calendar.new(calendar_params)
   lines=DefaultCalendar.where(anio: @calendar.anio).first
   if !lines.nil?
    lines=lines.default_line_calendars
     # assign default line calendars for year.
     lines.each do |line|
      @calendar.line_calendars.build(:fecha => line.fecha,:dia => line.nombre,:status => line.status)
     end
   end
   if(@calendar.save)
      flash[:success]="Ejercicio activado correctamente. Se han asignado los dias no laborales por defecto. Acceda a 'Dias festivos' si desea modificarlos "
      redirect_to calendars_url
   else
      render 'new'
    end
  end

  # get all calendars from department in enterprise logged in.
  def index
     #@dptos=Department.where(enterprise_id: current_emp.id)
     @calendars=Calendar.where(department_id: @dptos)   
      # filters
     @calendars=@calendars.filter(params.slice(:status,:department))
  end

  # close calendar
  def destroy
    @cal=Calendar.find(params[:id])
    @cal.status=!@cal.status?
    @cal.fecha_cierre=Date.current
    if @cal.save
        flash[:success]="Ejercicio cerrado correctamente"
    else
        flash[:error]= "Se ha producido un error al cerrar el ejercicio. Vuelta a intentarlo mas tarde"
    end
     redirect_to calendars_url
  end

  # line_calendars for calendar
  def show
    @cal=Calendar.find(params[:id])
  end

  def ausencias 
    @cal=Calendar.find(params[:id])
  end
    

  def days
    @cal=Calendar.find(params[:id])
  end

  # reopen calendar
  def update
      @cal=Calendar.find(params[:id])
     if @cal.update_attributes(:status => 't',:fecha_cierre => "")
            flash[:success] = "Ejercicio actualizado correctamente"      
     else
            flash[:success] = "Se ha producido un error al actualizar el ejercicio. "
     end
       redirect_to calendars_url
  end

  def update_days
      @cal=Calendar.find(params[:id])
     if @cal.update_attributes(calendar_params)
            flash[:success] = "Ejercicio actualizado correctamente"      
     else
            flash[:success] = "Se ha producido un error. "
     end
       redirect_to calendars_url
  end
  #private methods
  private

  def calendar_params
    params.require(:calendar).permit(:anio,:fecha_apertura,:fecha_cierre,:status,:d1,:d2,:d3,:d4,:d5,:d6,:d7,:department_id)
  end

  # before filers

  # calendario pertenece a empresa autentificada ?.
  def correct_calendar
      @calcheck=Department.find(Calendar.find(params[:id]).department_id)
      redirect_to(calendars_url) unless current_emp.id==@calcheck.enterprise_id || current_user.role>3      
   end

   # departments of logged admin's logged enterprise 
   def set_departments
    @dptos=Department.where(enterprise_id: current_emp.id)
   end
end
