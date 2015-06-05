class EmployeesController < ApplicationController
  
  before_action :signed_in_user
  before_action :set_employee, only: [:balance,:edit, :update, :show, :destroy]
  before_action :chief_user, only: [:index]
  before_action :admin_user, only: [:destroy]
  before_action :acceso_balance, only: [:balance,:show]
  before_action :correct_user, only: [:edit, :update] # check user is from your own emp.
  before_action :correct_emp, only: [:destroy]


    def show
      # next request from employee
      @nextRequest=Request.unscoped.where(:employee_id => current_user).where('desde>?',Time.now).order('desde asc').first

      # next holidays for employee
      @nextfree=Calendar.where(:department_id => current_user.department,:anio => Date.current.year).first
      if !@nextfree.nil?
        @nextfree=@nextfree.line_calendars.unscoped.where('fecha>?',Date.current).order('fecha asc').first
        @last_calendar = current_user.department.calendars.order('anio desc').first
        tot_request = current_user.requests
        @total = tot_request.count
        if(@total>0)
          @tot_rejected = (tot_request.where(:status => 0).count * 100) / @total
        else
          @tot_rejected = 0
        end
        @request_types = current_user.department.request_types.where(:status => 1).count
      end

      if emp_user?
         @requests=@emp.requests.where(:status => 1)
      elsif chief_user?
        @requests=@emp.requests.where(:status => 1)
        @tot_emp = current_user.department.employees.count
        tot_request = Request.where(:employee_id => current_user.department.employees)
        @total = tot_request.count
        @tot_availabilities = current_user.department.availabilities.count
        if(@total>0)
          @tot_rejected = (tot_request.where(:status => 0).count *100) / @total
        else
          @tot_rejected = 0
        end
        @last_calendar = current_user.department.calendars.order('anio desc').first

      else admin_user?
        employees = Employee.where(:department_id => current_emp.departments,:status => 1)
        @tot_employees = employees.count
        @employees_month = employees.where('created_at>?',Time.now.beginning_of_month).count
        data_requests = Request.where(:employee_id => Employee.where(:department_id => current_emp.departments))
        @tot_requests = data_requests.count
        if(@tot_requests>0)
            @percent_rejected = (data_requests.where(:status => 0).count *100 ) / @tot_requests
        else
            @percent_rejected = 0
        end
        @requests_pending = data_requests.where(:status => 1).count
        @request_month = data_requests.where('created_at>?',Time.now.beginning_of_month).count
        @tot_departments = current_emp.departments.count
        @tot_requests_types = current_emp.request_types.count
        @tot_calendars = Calendar.where(:department_id => current_emp.departments).count
      end
    end

  	def new
  	  @emp=Employee.new
      @departments=Enterprise.find(current_emp).departments
  	end

  	def create
   		@emp=Employee.new(employee_params)
      @departments=Enterprise.find(current_emp).departments

      if(@emp.save)
   			flash[:success] = "Empleado dado de alta correctamente"
   			redirect_to employees_url
   		else
   			render 'new'
   		end
   	end 

    def index
      if params[:status].nil?
        params[:status] = true
      end
      if chief_user? && params[:department].nil?
        params[:department]=current_user.department.id
      end
      @dptos=current_emp.departments
      @employees=Employee.where(department_id: @dptos)
      # filters
      @employees=@employees.filter(params.slice(:status,:department))
    end
  
    def edit   
    end

    def update
      
      if @emp.update_attributes(employee_params)
          flash[:success] = "Perfil actualizado correctamente"
          
          if(@emp==current_user)
            redirect_to @emp
          else
            redirect_to employees_url
          end
      else
        render 'edit'
      end
    end


    def destroy
        if @emp.status
          newstatus = 0
        else
          newstatus = 1
        end

      if Employee.find(params[:id]).update_attribute(:status, newstatus)
        flash[:success]="Se ha actualizado el estado del empleado correctamente"
      end
       redirect_to employees_url
    end

  
    # show balance
    def balance
      
      @datos=Array.new
      @confirmados=Array.new
      @pendientes=Array.new
      @total_dias=Array.new
      @dias_habiles=Array.new
      @rts=Array.new
      @rtsdif=Array.new
      @calendars=Calendar.where(department_id: @emp.department)

      if !params[:calendar].blank?
         year=params[:calendar]
      else
         year=Date.current.year
      end

      @calselected=year
      #get request for user. for calendar
      calendar=Calendar.where(department_id: @emp.department,anio: year).first
      requests=Request.joins(:request_type).select('requests.id,requests.status,request_types.num_dias_max as maxdias,(hasta-desde)+1 as dias,desde,hasta,nombre,request_type_id as rid')
        .where(:employee_id => @emp.id,status: [1,2]).all.where('extract(year from desde)= ?',"#{year}")
     
      requests.each do |rq| 
       #working days.
       dias=weekdays_in_date_range(rq.desde..rq.hasta,calendar) 
       @dias_habiles[rq.id]=dias
       @total_dias[rq.id]=(rq.hasta-rq.desde).to_i+1

        if rq.status=="pendiente"        # pending
            if @pendientes[rq.rid].nil? 
              @pendientes[rq.rid]=dias
            else 
              @pendientes[rq.rid]+=dias
            end
        elsif rq.status=="confirmada"
           if @confirmados[rq.rid].nil? 
                @confirmados[rq.rid]=dias 
           else 
                @confirmados[rq.rid]+=dias
           end
        end
         # diferents request_types
         if !@rtsdif.include?(rq.rid)
            @rtsdif.push(rq.rid)
            @rts.push(id: rq.rid,nombre: rq.nombre,maxdias: rq.maxdias,dias_habiles: dias)
         end
      end

      @nodata_rt = @emp.department.request_types.where(:tipo => true,:status => true).where.not(id: @rtsdif).all

      @rts.each do |rq|

        if @pendientes[rq[:id]].nil? 
            @pendientes[rq[:id]]=0 
        end

        if @confirmados[rq[:id]].nil? 
            @confirmados[rq[:id]]=0 
         end

        rqts=Request.where(:request_type_id => rq[:id],:employee_id => @emp.id,status: [1,2]).all.where('extract(year from desde)= ?',"#{year}")
        @datos.push(
          requests: rqts,
          nombre: rq[:nombre],
          confirmados: @confirmados[rq[:id]], 
          pendientes: @pendientes[rq[:id]], 
          num_dias_max: Request.rest_days(year,@emp.id,rq[:maxdias])
        )
      end
    end


  private

    def set_employee
      @emp=Employee.find(params[:id])
    end

   	def employee_params
   		params.require(:employee).permit(:nombre,:email,:password,
   			:password_confirmation,:department_id, :role, :cargo, :fecha_alta, :fecha_baja)
   	end

    # before filers
  
    def correct_user
      if current_user.role<3
           redirect_to current_user unless current_user?(@emp)
      elsif current_user.role==3
        redirect_to current_user unless current_emp.departments.where(:id => @emp.department_id).any? 
      elsif current_user.role==4
        redirect_to admin_path
      end       
    end

    def correct_emp
       redirect_to current_user unless current_emp.departments.where(:id => @emp.department_id).any? 
    end

    def acceso_balance
      if current_user.role<2
           redirect_to current_user unless current_user?(@emp)
      elsif current_user.role==3
           redirect_to current_user unless current_emp.departments.where(:id => @emp.department_id).any? 
      elsif current_user.role==4
           redirect_to admin_path
      end
    end
    
   
end
