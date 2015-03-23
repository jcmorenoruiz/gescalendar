class UserMailer < ActionMailer::Base
  default from: "pfc.gescalendar@gmail.com"

   def welcome_email(user)
    @user = user
    @url  = 'http://gescalendar.herokuapp.com/singup'
    mail(to: @user.email, subject: 'Bienvenido a GesCalendar')
  end
end
