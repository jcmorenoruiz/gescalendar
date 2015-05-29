class RequestsController < ApplicationController
  
  before_action :signed_in_user
  before_action :chief_user, only: [:edit, :update,:pending]
  before_action :set_request, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update , :destroy]
  before_action :correct_user_new_create, only: [:new,:create]
  before_action :correct_dpto, only: [:calendar]

  def new
  	@emp=Employee.find(params[:id])
  	@request=Request.new

    if admin_user? && params[:id]!=current_user.id
      @request_types=Employee.find(params[:id]).department.request_types.where(:status => true,:tipo => true) 
    else
      @request_types=current_user.department.request_types.where(:status => true,:tipo => true)
    end

  end

  def create

		@emp = Employee.find(params[:request][:employee_id])

    #distingir por perfiles

    if admin_user? && @emp.id!=current_user.id
      @request_types=Employee.find(@emp.id).department.request_types.where(:status => true,:tipo => true) 
    else
      @request_types=current_user.department.request_types.where(:status => true,:tipo => true)
    end
    

    @request= @emp.requests.build(requests_params)
    if admin_user? 
      @request.status=2  
    end

    if @request.save

      if current_emp.notif_solicitudes 
        UserMailer.nueva_solicitud(@request).deliver
      end
      if admin_user?
        flash[:success]= 'Asignación de Ausencia generada correctamente. Se ha enviado un email a los empleados indicando la Ausencia.'
        redirect_to employees_path
      else
        flash[:success]= 'Solicitud generada correctamente. Se le notificará el resultado de la auditoría cuando sea efectuada.'
        redirect_to employee_path(@emp)
      end        
    else
        render "new" 
    end

  end

  def edit
     
  end

  def update

      if @request.update_attributes(:status => params[:request][:status],:motivo_rev => params[:request][:motivo_rev])
          if current.notif_auditoria 
            UserMailer.auditoria_solicitud(@request).deliver
          end
          flash[:success]="Solicitud procesada correctamente. Se ha enviado un email con el aviso correspondiente."
          redirect_to requests_pending_path
      else
          render "edit"
      end
  end

  def show 
   
  end
  

  def destroy   
    @emp = Employee.find(@request.employee_id)
    @request.destroy
    flash[:success]='Solicitud anulada correctamente'
    redirect_to employee_path(@emp) 
  end

  def stats
    @calendars=Calendar.select('distinct anio').where(department_id: current_emp.departments)

    if !params[:calendar].blank?
      @year=params[:calendar]
    else
      @year=Date.current.year
    end



    if !params[:department].blank?
     @requests_types=RequestType.where(:id => DepartmentsRequestType.select('request_type_id').where(:department_id => params[:department]))
     @requests=Request.where(:employee_id => Employee.where(:department_id => params[:department]))
    else
     @requests_types=RequestType.where(:enterprise_id => current_emp)
     @requests=Request.where(:employee_id => Employee.where(:department_id => current_emp.departments))
    end
    


    @dptos=Department.where(:enterprise_id =>current_emp)
  end


  def calendar
    @dptos=Department.where(:enterprise_id =>current_emp)
    @ndias=['D','L','M','X','J','V','S']
    @requests_types=RequestType.where(:enterprise_id => current_emp)
    
    @date=Date.today
    
    if params[:date].present?
      if !params[:date][:month].blank? || !params[:date][:year].blank?
        @date=Date.new(params[:date][:year].to_i,params[:date][:month].to_i,1)  
      end
    end 
    # generate header calendar table
    @iniciomes=Date.new(@date.year,@date.month,1)
    @finmes=Date.new(@date.year,@date.month,@date.end_of_month.day)
    @nombredias=(@iniciomes..@finmes).map{ |date| @ndias[date.wday] }
    @diasmes=(1..@date.end_of_month.day).to_a
    @fechas=(@iniciomes..@finmes).map{ |date| date }
   
    params[:starts_with].present? ? nombre=params[:starts_with] : nombre=""

    if params[:department].present?
        @employees=Employee.where(:department_id => params[:department]).where('upper(nombre) like ?',"%#{nombre.upcase}%")
    else
        @employees=Employee.where(:department_id => current_emp.departments).where('upper(nombre) like ?',"%#{nombre.upcase}%")
    end
    

  end

  def pending
    # filling dropdown.
    @dptos=Department.where(enterprise_id: current_emp.id) # departments from enterprise
    @rts=RequestType.where(enterprise_id: current_emp.id) # request types for enterprise


    if chief_user?      
      @requests=Request.where(:status => 1,:employee_id => Department.find(current_user.department_id).employees).paginate(page: params[:page])
    else admin_user?        
      @requests=Request.where(:status => 1,:employee_id => Employee.where(:department_id =>Department.where(:enterprise_id => current_emp.id))).paginate(page: params[:page])
    end

    # filters
    @requests=@requests.filter(params.slice(:department,:request_type,:starts_with))
    # paginate
    @requests=@requests.paginate(page: params[:page]) 
  end

  def export_requests
    @departments=Department.where(:enterprise_id => current_emp)

     respond_to do |format|    
        format.xlsx {
          response.headers['Content-Disposition'] = 'attachment; filename="my_new_filename.xlsx"'
        }
    end
  end

  

  protected

  def weekdays_in_date_range(range)
    # You could modify the select block to also check for holidays
    range.select { |d| (1..5).include?(d.wday) }.size
  end

  private

   def correct_user
      if current_user.role<2
          redirect_to current_user
      elsif current_user.role==2
           redirect_to current_user unless @request.employee.department.id==current_user.department.id
      elsif current_user.role==3
        redirect_to current_user unless current_emp.departments.where(:id => @request.employee.department.id).any? 
      elsif current_user.role==4
        redirect_to admin_path
      end       
    end

     def correct_user_new_create
      if current_user.role<3
          redirect_to current_user unless Employee.find(params[:id])==current_user
      elsif current_user.role==3
        redirect_to current_user unless current_emp.departments.where(:id => Employee.find(params[:id]).department.id).any? 
      elsif current_user.role==4
        redirect_to admin_path
      end       
    end


   def set_request
      @request = Request.find(params[:id])
    end

  	def requests_params
  		 params.require(:request).permit(:desde, :hasta, :request_type_id, :motivo)
  	end

end
