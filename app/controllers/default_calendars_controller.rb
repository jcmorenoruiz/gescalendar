class DefaultCalendarsController < ApplicationController
  before_action :set_default_calendar, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user
  before_action :superadmin_user

  # GET /default_calendars
  # GET /default_calendars.json
  def index
    @default_calendars = DefaultCalendar.all
  end

  # GET /default_calendars/1
  # GET /default_calendars/1.json
  def show
  end

  # GET /default_calendars/new
  def new
    @default_calendar = DefaultCalendar.new
  end

  # GET /default_calendars/1/edit
  def edit
  end

  # POST /default_calendars
  # POST /default_calendars.json
  def create
    @default_calendar = DefaultCalendar.new(default_calendar_params)

    respond_to do |format|
      if @default_calendar.save
        format.html { redirect_to @default_calendar, notice: 'Default calendar was successfully created.' }
        format.json { render :show, status: :created, location: @default_calendar }
      else
        format.html { render :new }
        format.json { render json: @default_calendar.errors, status: :unprocessable_entity }
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
    @default_calendar.destroy
    respond_to do |format|
      format.html { redirect_to default_calendars_url }
      format.json { head :no_content }
    end
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
