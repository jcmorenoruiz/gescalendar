class RequestTypesController < ApplicationController
 
  before_action :signed_in_user
  before_action :admin_user
  before_action :set_request_type, only: [:show, :edit, :update, :destroy]
  before_action :correct_enterprise, only: [:edit, :update , :destroy]
  
  include DepartmentsRequestTypesHelper

  # GET /request_types/new
  def new
    @request_type = RequestType.new
  end


  def index
    @request_types=RequestType.where(:enterprise_id => current_emp)
   
    # filters
    params[:status] ||= true 
    @request_types=@request_types.filter(params.slice(:status,:starts_with)) # concern filterable
    # paginate
    @request_types=@request_types.paginate(page: params[:page]) 
  end

  # GET /request_types/1/edit
  def edit
    
  end

  # POST /request_types
  # POST /request_types.json
  def create
    
    @request_type = current_emp.request_types.build(request_type_params)

    if @request_type.save
      flash[:success]="Tipo de solicitud creada correctamente"
      redirect_to request_types_path
    else        
      render :new 
    end
    
  end
  
  # PATCH/PUT /request_types/1
  # PATCH/PUT /request_types/1.json
  def update     
      if @request_type.update(request_type_params)
          flash[:success]="Tipo de solicitud actualizada correctamente"
          redirect_to request_types_path
      else
          render "edit"
      end
    
  end

  # DELETE /request_types/1
  # DELETE /request_types/1.json
  def destroy
    @request_type.status=!@request_type.status?
    if @request_type.save
        flash[:success]="Ausencia actualizada correctamente"
        redirect_to request_types_path
    end
  end


  


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request_type
      @request_type = RequestType.find(params[:id])
    end

    def correct_enterprise
      redirect_to(request_types_url) unless current_emp.id==@request_type.enterprise_id || current_user.role>3      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def request_type_params
      params.require(:request_type).permit(:nombre,:color, :num_dias_max, :status, :calendar_id,:tipo)
    end



end
