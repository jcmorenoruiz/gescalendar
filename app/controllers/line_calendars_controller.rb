class LineCalendarsController < ApplicationController
  before_action :set_line_calendar, only: [:edit, :update, :destroy]
  before_action :signed_in_user
  before_action :admin_user
  before_action :correct_calendar, only: [:index,:edit,:create,:update,:destroy]
  # GET /line_calendars
  # GET /line_calendars.json
  def index
    @line_calendars = Calendar.find(params[:id]).linecalendars
  end

  # GET /line_calendars/new
  def new
    @calendar=Calendar.find(params[:calendar_id])
    @line_calendar = LineCalendar.new
  end

  # GET /line_calendars/1/edit
  def edit
    @line_calendar=LineCalendar.find(params[:id])
    @calendar=Calendar.find(@line_calendar.calendar_id)
  end

  # POST /line_calendars
  # POST /line_calendars.json
  def create
   
    @calendar = Calendar.find(params[:line_calendar][:calendar_id])
    @line_calendar = @calendar.line_calendars.build(line_calendar_params)

    if @line_calendar.save
        flash[:success]= 'Dia no laborable agregado correctamente al calendario'
        redirect_to calendar_path(@calendar)
    else
        render "new" 
    end
  end

  # PATCH/PUT /line_calendars/1
  # PATCH/PUT /line_calendars/1.json
  def update
     @calendar=Calendar.find(@line_calendar.calendar_id)
    if @line_calendar.update(line_calendar_params)
        flash[:success] = "Dia no laborable actualizado correctamente"
        redirect_to calendar_path(@line_calendar.calendar_id)
    else
        render 'edit'
    end
  end

  # DELETE /line_calendars/1
  # DELETE /line_calendars/1.json
  def destroy
    if @line_calendar.destroy
        flash[:success]= 'Dia no laborable eliminado correctamente'
        redirect_to calendar_path(@line_calendar.calendar_id)
    end
  end

 def active
     
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_calendar
      @line_calendar = LineCalendar.find(params[:id])
    end

    def correct_calendar
      if(!@line_calendar.nil?)
        @calcheck=Department.find(@line_calendar.calendar.department_id)
      else
        @calcheck=Department.find(Calendar.find(params[:line_calendar][:calendar_id]).department_id)
      end
      redirect_to(calendars_url) unless current_emp.id==@calcheck.enterprise_id || current_user.role>3      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_calendar_params
      params.require(:line_calendar).permit(:fecha, :dia, :desc,:calendar_id)
    end

end
