class SessionsController < ApplicationController

	protect_from_forgery with: :exception
	include SessionsHelper 	# incluimos

	def new
	end

	def create

		emp=Employee.find_by(email: params[:session][:email].downcase)
		
		respond_to do |format|

			if emp && (!emp.status || !emp.department.enterprise.status)
				flash[:danger] = "Usuario no autorizado para acceder al sistema"
				format.html { render action: 'new' }
	      format.json { render json: @emp.errors, status: :unprocessable_entity }
			elsif emp && emp.authenticate(params[:session][:password])
				#flash[:success] = "Autentificación correcta"
				sign_in emp # create sessions
				format.html { 
					if(superadmin_user?)
						redirect_back_or admin_path
					elsif(admin_user?)
						redirect_back_or emp
					else
						redirect_back_or emp
					end
				}
				#format.json { render :show, status:created, location: emp}
			else
				flash.now[:danger]= "Combinación de email/password incorrecta"
				format.html { render action: 'new' }
	      		format.json { render json: @emp.errors, status: :unprocessable_entity }
				
			end 
		end
	
	end

	def destroy
		sign_out
		redirect_to root_url
	end

	

end
