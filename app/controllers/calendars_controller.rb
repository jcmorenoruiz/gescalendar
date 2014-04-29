class CalendarsController < ApplicationController
 
  #common methods
  def new
    @calendar=Calendar.new
    @years=2.years.ago.year..Time.now.year+1 # years range
  end

 def create
   @calendar=Calendar.new(calendar_params)
   @calendar.enterprise_id=current_emp.id
    
   if(@calendar.save)
      flash[:success]="Ejercicio activado correctamente"
      redirect_to calendars_url
   else
      render 'new'
    end
  end

  def index
     @calendars=Calendar.where(enterprise_id: current_emp.id)   
  end

  # cerrar calendario
  def destroy
    @cal=Calendar.find(params[:id])
    if @cal.update_attribute(:status, 'f')
      flash[:success]="Ejercicio cerrado correctamente"
    else 
      flash[:error]= "Se ha producido un error al cerrar el ejercicio. Vuelta a intentarlo mas tarde"
    end
     redirect_to calendars_url

  end


  def show
    @cal=Calendar.find(params[:id])
  end

  def update
      @cal=Calendar.find(params[:id])
     if @cal.update_attributes(calendar_params)
            flash[:success] = "Ejercicio actualizado correctamente"
          
     else
            flash[:success] = "Se ha producido un error al actualizar el Ejercicio. Por favor, vuelva a intentarlo mas tarde"
     end
       redirect_to calendars_url
  end


  #private methods
  private

  def calendar_params
    params.require(:calendar).permit(:anio,:fecha_apertura,:status)
  end
end
