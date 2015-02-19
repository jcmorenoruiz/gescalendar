module SessionsHelper

	def sign_in(emp)
		remember_token = Employee.new_remember_token
		cookies.permanent[:remember_token]= remember_token
		emp.update_attribute(:remember_token,Employee.digest(remember_token))
		self.current_user=emp
	end

	def sign_out
		current_user.update_attribute(:remember_token, Employee.digest(Employee.new_remember_token))
		cookies.delete(:remember_token)
		self.current_user=nil
	end

	def signed_in?
		!current_user.nil?
	end

	def current_user=(emp)
		@current_user=emp
	end

	def current_user
		remember_token = Employee.digest(cookies[:remember_token])
		@current_user ||= Employee.find_by(remember_token: remember_token)
	end

	def current_user?(emp)
		emp==current_user
	end

	# obtener la empresa del empleado autentificado.
	def current_emp
		user=self.current_user
		dpto=Department.find(user.department_id)
		@current_emp=Enterprise.find(dpto.enterprise_id) if dpto
	end
	def current_dpto
		user=self.current_user
		dpto=Department.find(user.department_id)
	end

	def store_location
		session[:return_to]= request.url if request.get?
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Por favor, identifiquese!" 
      end
    end

    def emp_user?
      current_user.role==1
    end

    def chief_user?
    	current_user.role==2
    end

    def chief_user
    	redirect_to(current_user) unless current_user.role>=2
    end

     # Enterprise Administrator
    def admin_user
      redirect_to(current_user) unless current_user.role==3
    end
 
    def admin_user?
      current_user.role==3
    end

    # Aplication Administrator 
    def superadmin_user
       redirect_to(current_user) unless current_user.role==4
    end

    def superadmin_user?
      current_user.role==4	
    end

    # return current Role name
    def current_role
    	case current_user.role
    	when 1 
    		@current_role='Empleado'
    	when 2 
    		@current_role='Jefe Departamento'
    	when 3 
    		@current_role='Administrador'
    	when 4 
    		@current_role='SuperAdmin'
    	end
    end

end
