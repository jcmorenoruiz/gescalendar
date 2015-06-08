class PasswordResetsController < ApplicationController


  def new
  end

  def create
    @user = Employee.find_by(email: params[:password_reset][:email].downcase)

    if @user
      newpass = Employee.new_password
      if @user.update_attributes(:password => newpass,:password_confirmation => newpass)
        UserMailer.password_reset(@user,newpass).deliver_now
        flash[:success] = "Se le ha enviado un email con las instrucciones para recuperar la constraseña"
        redirect_to signin_path
      else
        flash.now[:danger] = "Se ha producido un error al generar el nuevo password. Por favor, vuelva a intentarlo."
        render 'new'
      end
    else
      flash.now[:danger] = "No se ha encontrado el correo electronico indicado."
      render 'new'
    end
  end


  private

  def get_user
      @user = Employee.find_by(email: params[:email])
  end

  def employee_params
      params.require(:employee).permit(:password, :password_confirmation)
  end

  # Confirms a valid user.
  def valid_user
    unless (@user && @user.status && @user.authenticated?(:reset, params[:id]))
      redirect_to root_url
    end
  end

end