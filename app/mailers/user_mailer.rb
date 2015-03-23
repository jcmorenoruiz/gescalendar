class UserMailer < ActionMailer::Base
  default from: "pfc.gescalendar@gmail.com"

   def welcome_email(user)
     @user = user
	    mg_client = Mailgun::Client.new ENV['api_key']
	    message_params = {:from    => ENV['gmail_username'],
	                      :to      => @user.email,
	                      :subject => 'Bienvenido a GesCalendar',
	                      :text    => 'This mail is sent using Mailgun API via mailgun-ruby'}
	    mg_client.send_message ENV['domain'], message_params
  end
end

