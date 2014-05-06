class RequestTypesController < ApplicationController
  before_action :set_request_type, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user
  before_action :admin_user
  before_action :correct_calendar, only: [:new, :edit, :update , :destroy]


  # GET /request_types/new
  def new
      @calendar=Calendar.find(params[:calendar_id])
    @request_type = RequestType.new
  end

  # GET /request_types/1/edit
  def edit
      @calendar=Calendar.find(@request_type.calendar_id)
  end

  # POST /request_types
  # POST /request_types.json
  def create
    @calendar = Calendar.find(params[:request_type][:calendar_id])
    @request_type = @calendar.request_types.build(request_type_params)

    if @request_type.save
        flash[:success]="Tipo de solicitud creada correctamente"
         redirect_to :controller => 'calendars', :action => 'ausencias', id: @calendar.id
    else        
        render :new 
    end
    
  end
  
  # PATCH/PUT /request_types/1
  # PATCH/PUT /request_types/1.json
  def update   
      if @request_type.update(request_type_params)
          flash[:success]="Tipo de solicitud actualizada correctamente"
          redirect_to :controller => 'calendars', :action => 'ausencias', id: @request_type.calendar_id
      else
          render "edit"
      end
    
  end

  # DELETE /request_types/1
  # DELETE /request_types/1.json
  def destroy
    @request_type.status=!@request_type.status?
    if @request_type.save
        session[:success]="Ausencia actualizada correctamente"
        redirect_to :controller => 'calendars', :action => 'ausencias', id: @request_type.calendar_id
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request_type
      @request_type = RequestType.find(params[:id])
    end

    def correct_calendar
      if !@request_type.nil?
        @calcheck=Department.find(@request_type.calendar.department_id)
      else
        @calen=Calendar.find(params[:calendar_id])
        @calcheck=Department.find(@calen.department_id)
      end
      
      redirect_to(calendars_url) unless current_emp.id==@calcheck.enterprise_id || current_user.role>3      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def request_type_params
      params.require(:request_type).permit(:nombre, :num_dias_max, :status, :calendar_id)
    end
end
