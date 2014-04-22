class SessionsController < ApplicationController

	protect_from_forgery with: :exception
	include SessionsHelper 	# incluimos

	def new
	end

	def create
	
		emp=Employee.find_by(email: params[:session][:email].downcase)
		if emp && emp.authenticate(params[:session][:password])
			sign_in emp
			redirect_back_or emp
		else
			flash.now[:error]= "Combinación de email/password incorrecta"
			render 'new'
		end
	
	end

	def destroy
		sign_out
		redirect_to root_url
	end

	

end
