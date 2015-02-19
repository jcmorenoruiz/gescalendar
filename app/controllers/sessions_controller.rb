class SessionsController < ApplicationController

	protect_from_forgery with: :exception
	include SessionsHelper 	# incluimos

	def new
	end

	def create

		emp=Employee.find_by(email: params[:session][:email].downcase)
		
		respond_to do |format|

			if emp && emp.authenticate(params[:session][:password])
				flash.now[:success] = "Autentificación correcta"
				sign_in emp # create sessions
				format.html { redirect_back_or emp }
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
