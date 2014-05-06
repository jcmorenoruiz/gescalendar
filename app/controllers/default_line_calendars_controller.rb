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
    @default_line_calendar = DefaultLineCalendar.new
  end

  # GET /default_line_calendars/1/edit
  def edit
  end

  # POST /default_line_calendars
  # POST /default_line_calendars.json
  def create
    @default_line_calendar = DefaultLineCalendar.new(default_line_calendar_params)

    respond_to do |format|
      if @default_line_calendar.save
        format.html { redirect_to @default_line_calendar, notice: 'Default line calendar was successfully created.' }
        format.json { render :show, status: :created, location: @default_line_calendar }
      else
        format.html { render :new }
        format.json { render json: @default_line_calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /default_line_calendars/1
  # PATCH/PUT /default_line_calendars/1.json
  def update
    respond_to do |format|
      if @default_line_calendar.update(default_line_calendar_params)
        format.html { redirect_to @default_line_calendar, notice: 'Default line calendar was successfully updated.' }
        format.json { render :show, status: :ok, location: @default_line_calendar }
      else
        format.html { render :edit }
        format.json { render json: @default_line_calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /default_line_calendars/1
  # DELETE /default_line_calendars/1.json
  def destroy
    @default_line_calendar.destroy
    respond_to do |format|
      format.html { redirect_to default_line_calendars_url }
      format.json { head :no_content }
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
