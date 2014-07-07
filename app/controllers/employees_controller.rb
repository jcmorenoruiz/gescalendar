class EmployeesController < ApplicationController
  
before_action :signed_in_user
before_action :set_employee, only: [:balance,:edit, :update, :show]

before_action :chief_user, only: [:index]
before_action :admin_user, only: [:destroy]

before_action :acceso_balance, only: [:balance]

before_action :correct_user, only: [:edit, :update] # check user is from your own emp.
before_action :correct_emp, only: [:destroy,:balance]

    def show
      @nextRequest=Request.unscoped.where(:employee_id => current_user).where('desde>?',Time.now).order('desde asc').first
      @nextfree=Calendar.where(:department_id => current_emp.departments).first
      if !@nextfree.nil?
        @nextfree=@nextfree.line_calendars.unscoped.where('fecha>?',Date.current).first
      end

      if emp_user?
         @requests=@emp.requests.where(:status => 1,
            :employee_id => current_user.id).paginate(page: params[:page])
      elsif chief_user?      
        @requests=Request.where(:status => 1,:request_type_id => Department.find(
          current_user.department_id).request_types).paginate(page: params[:page])
      else admin_user?        
         @requests=Request.where(:status => 1,:request_type_id => Department.find(
          current_user.department_id).request_types).paginate(page: params[:page])
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

      @dptos=Department.where(enterprise_id: current_emp.id) # departments from enterprise
      @employees=Employee.where(department_id: @dptos)
      # filters
      @employees=@employees.filter(params.slice(:status,:department,:starts_with))
      # paginate
      @employees=@employees.paginate(page: params[:page]) # employes on departments
    
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
      if Employee.find(params[:id]).update_attribute(:status, 0)
        flash[:success]="Empleado dado de baja correctamente"
      end
       redirect_to employees_url
    end

  
    # show balance
    def balance
      
      @datos=Array.new
      @confirmados=Array.new
      @pendientes=Array.new
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
     

      requests=Request.joins(:request_type).select('requests.status,request_types.num_dias_max as maxdias,desde,hasta,(hasta-desde)+1 as dias,nombre,request_type_id as rid').where(:employee_id => @emp.id,status: [1,2]).all.where('extract(year from desde)= ?',"#{year}")
     
      requests.each do |rq| 
       
        if rq.status==1        # pending
          if @pendientes[rq.rid].nil? 
            @pendientes[rq.rid]=rq.dias 
          else 
            @pendientes[rq.rid]+=rq.dias 
          end
        end

         if @confirmados[rq.rid].nil? 
              @confirmados[rq.rid]=rq.dias 
         else 
              @confirmados[rq.rid]+=rq.dias 
         end
         if @pendientes[rq.rid].nil? 
          @pendientes[rq.rid]=0 
         end
         # diferents request_types
         if !@rtsdif.include?(rq.rid)
            @rtsdif.push(rq.rid)
            @rts.push(id: rq.rid,nombre: rq.nombre,maxdias: rq.maxdias)
         end

      end

      @rts.each do |rq|
        rqts=Request.where(:request_type_id => rq[:id],:employee_id => @emp.id,status: [1,2]).all.where('extract(year from desde)= ?',"#{year}")
        @datos.push(requests: rqts,nombre: rq[:nombre],confirmados: @confirmados[rq[:id]], pendientes: @pendientes[rq[:id ]], num_dias_max: rq[:maxdias])
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
        redirect_to current_user unless current_emp.departments.where(:id => @emp.department_id) 
      end        
    end

    def correct_emp
       redirect_to current_user unless current_emp.departments.where(:id => @emp.department_id) 
    end

    def acceso_balance
      if current_user.role<2
           redirect_to current_user unless current_user?(@emp)
      else
           redirect_to current_user unless current_emp.departments.where(:id => @emp.department_id) 
      end        
    end
    
   
end
