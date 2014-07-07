class DepartmentsRequestTypesController < ApplicationController
  before_action :set_departments_request_type, only: [:show, :edit, :update, :destroy]

  # GET /departments_request_types
  # GET /departments_request_types.json
  def index
    @departments_request_types = DepartmentsRequestType.all
  end

  # GET /departments_request_types/1
  # GET /departments_request_types/1.json
  def show
  end

  # GET /departments_request_types/new
  def new
    @departments_request_type = DepartmentsRequestType.new
  end

  # GET /departments_request_types/1/edit
  def edit
  end

  # POST /departments_request_types
  # POST /departments_request_types.json
  def create
    @departments_request_type = DepartmentsRequestType.new(departments_request_type_params)

    respond_to do |format|
      if @departments_request_type.save
        format.html { redirect_to @departments_request_type, notice: 'Departments request type was successfully created.' }
        format.json { render :show, status: :created, location: @departments_request_type }
      else
        format.html { render :new }
        format.json { render json: @departments_request_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /departments_request_types/1
  # PATCH/PUT /departments_request_types/1.json
  def update
    respond_to do |format|
      if @departments_request_type.update(departments_request_type_params)
        format.html { redirect_to @departments_request_type, notice: 'Departments request type was successfully updated.' }
        format.json { render :show, status: :ok, location: @departments_request_type }
      else
        format.html { render :edit }
        format.json { render json: @departments_request_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /departments_request_types/1
  # DELETE /departments_request_types/1.json
  def destroy
    @departments_request_type.destroy
    respond_to do |format|
      format.html { redirect_to departments_request_types_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_departments_request_type
      @departments_request_type = DepartmentsRequestType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def departments_request_type_params
      params.require(:departments_request_type).permit(:num_max_dias, :request_type_id, :department_id)
    end
end
