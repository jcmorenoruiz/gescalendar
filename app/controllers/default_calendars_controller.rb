class DefaultCalendarsController < ApplicationController
  include DefaultCalendarsHelper
  before_action :set_default_calendar, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user
  before_action :superadmin_user

  # GET /default_calendars
  # GET /default_calendars.json
  def index
    @default_calendars = DefaultCalendar.all
    # filters
    @default_calendars=@default_calendars.filter(params.slice(:status))
  end

  # GET /default_calendars/1
  # GET /default_calendars/1.json
  # line_calendars for calendar
  def show
    @cal=DefaultCalendar.find(params[:id])
  end

  # GET /default_calendars/new
  def new
    @default_calendar = DefaultCalendar.new
  end


  # POST /default_calendars
  # POST /default_calendars.json
  def create
    @default_calendar = DefaultCalendar.new(default_calendar_params)

    respond_to do |format|
      if @default_calendar.save
          flash[:success] = "Empleado dado de alta correctamente"
        format.html { redirect_to default_calendars_path }
      else
        format.html { render :new }
      end
    end
    
  end

  # PATCH/PUT /default_calendars/1
  # PATCH/PUT /default_calendars/1.json
  def update

    respond_to do |format|
      if @default_calendar.update(default_calendar_params)

        format.html { redirect_to @default_calendar, notice: 'Default calendar was successfully updated.' }
        format.json { render :show, status: :ok, location: @default_calendar }
      else
        format.html { render :edit }
        format.json { render json: @default_calendar.errors, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /default_calendars/1
  # DELETE /default_calendars/1.json 
    def destroy
      @default_calendar=DefaultCalendar.find(params[:id])

        if(@default_calendar.status)
          @default_calendar.update_attribute(:status,0)
          flash[:success]="Calendario desactivado correctamente"   
        else 
          @default_calendar.update_attribute(:status,1)
          flash[:success]="Calendario reactivado correctamente"   
        end
      
      redirect_to default_calendars_url
    end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_default_calendar
      @default_calendar = DefaultCalendar.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def default_calendar_params
      params.require(:default_calendar).permit(:anio, :status)
    end
end
