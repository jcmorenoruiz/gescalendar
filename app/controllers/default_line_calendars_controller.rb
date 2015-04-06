class DefaultLineCalendarsController < ApplicationController
  before_action :set_default_line_calendar, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user
  before_action :superadmin_user

  # GET /default_line_calendars
  # GET /default_line_calendars.json
  def index
    @default_line_calendars = DefaultLineCalendar.all
  end

  # GET /default_line_calendars/1
  # GET /default_line_calendars/1.json
  def show
  end

  # GET /default_line_calendars/new
  def new
    @calendar=DefaultCalendar.find(params[:calendar_id])
    @line_calendar = DefaultLineCalendar.new
  end

  # GET /default_line_calendars/1/edit
  def edit
    @line_calendar=DefaultLineCalendar.find(params[:id])
    @calendar=DefaultCalendar.find(@line_calendar.default_calendar_id)
  end

  # POST /default_line_calendars
  # POST /default_line_calendars.json
  def create
    @calendar = DefaultCalendar.find(params[:default_line_calendar][:calendar_id])
    @line_calendar = @calendar.default_line_calendars.build(default_line_calendar_params)

    if @line_calendar.save
        flash[:success]= 'Dia no laborable agregado correctamente al calendario'
        redirect_to default_calendar_path(@calendar)
    else
        render "new" 
    end
  end

  # PATCH/PUT /default_line_calendars/1
  # PATCH/PUT /default_line_calendars/1.json
  def update
     @calendar=DefaultCalendar.find(@default_line_calendar.default_calendar_id)
      if @default_line_calendar.update(default_line_calendar_params)
          flash[:success] = "Dia no laborable actualizado correctamente"
          redirect_to default_calendar_path(@default_line_calendar.default_calendar_id)
      else
          render 'edit'
      end
  end

  # DELETE /default_line_calendars/1
  # DELETE /default_line_calendars/1.json
  def destroy
    if @default_line_calendar.destroy
        flash[:success]= 'Dia no laborable eliminado correctamente'
        redirect_to default_calendar_path(@default_line_calendar.default_calendar_id)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_default_line_calendar
      @default_line_calendar = DefaultLineCalendar.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def default_line_calendar_params
      params.require(:default_line_calendar).permit(:fecha, :nombre, :status)
    end
end
