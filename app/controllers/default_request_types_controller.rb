class DefaultRequestTypesController < ApplicationController
  before_action :set_default_request_type, only: [:show, :edit, :update, :destroy]

  # GET /default_request_types
  # GET /default_request_types.json
  def index
    @default_request_types = DefaultRequestType.all
    # filters
    @default_request_types=@default_request_types.filter(params.slice(:status,:starts_with))
  end

  # GET /default_request_types/new
  def new
    @default_request_type = DefaultRequestType.new
  end

  # GET /default_request_types/1/edit
  def edit
  end

  # POST /default_request_types
  # POST /default_request_types.json
  def create
    @default_request_type = DefaultRequestType.new(default_request_type_params)

    respond_to do |format|
      if @default_request_type.save
        flash[:success]='Tipo de solicitud creada satisfactoriamente'
        format.html { redirect_to default_request_types_path }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /default_request_types/1
  # PATCH/PUT /default_request_types/1.json
  def update
    respond_to do |format|
      if @default_request_type.update(default_request_type_params)
        flash[:success]='Tipo de solicitud actualizado con éxito'
        format.html { redirect_to default_request_types_path }    
      else
        format.html { render :edit }   
      end
    end
  end

  # DELETE /default_request_types/1
  # DELETE /default_request_types/1.json
  def destroy

    respond_to do |format|
    
      if @default_request_type.destroy
        flash[:success]="Calendario eliminado correctamente."   
        format.html { redirect_to default_request_types_url }
        format.json { head :no_content }
      else
        flash[:danger]="Se ha producido un error al intentar eliminar el calendario."   
         format.html { redirect_to default_request_types_url }
      end
    end
   
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_default_request_type
      @default_request_type = DefaultRequestType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def default_request_type_params
      params.require(:default_request_type).permit(:nombre, :num_dias_max, :status)
    end

   
end
