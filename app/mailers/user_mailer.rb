class UserMailer < ActionMailer::Base

  default from: "pfc.gescalendar@gmail.com"

  def welcome_email(user)
    @user = user
    @url  = 'http://gescalendar.herokuapp.com'
    mail(to: @user.email, subject: 'Bienvenido a GesCalendar')
  end


  def auditoria_solicitud(request)
  	@request=request
  	@url  = 'http://gescalendar.herokuapp.com'
  	@user=request.employee
  	
  	puts @request.status
  	if(@request.status=='confirmada')
  		subject='Solicitud confirmada por el responsable del departamento.'
  	elsif(@request.status=='denegada')
  		subject='Solicitud denegada por el responsable del departamento.'
  	end

  	email_with_name = "#{@request.employee.nombre} <#{@request.employee.email}>"

  	# chief department 
  	@chief=@request.employee.department.employees.where(role: 2).first
  	chief_email = "#{@chief.nombre} <#{@chief.email}>"

  	# administrator
	@administrator=Employee.where(:department_id => Department.where(:enterprise_id => request.employee.department.enterprise)).where(:role => 3).first
	administrator_email = "#{@administrator.nombre} < #{@administrator.email}>"
  	
  	mail(to: [@request.employee.email, chief_email],cc: administrator_email, subject: subject)
  end


  def nueva_solicitud(request)
  	@request=request
  	@url  = 'http://gescalendar.herokuapp.com'
  	@user=request.employee

  	if(@request.status=='pendiente')
  		subject='El empleado '+@user.nombre+' ha realizado una solicitud de permiso de '+request.request_type.nombre
  	elsif(@request.status=='confirmada')
  		subject='Permiso de tipo '+request.request_type.nombre+' asignado a '+@user.nombre
  	end

  	# chief department 
  	
  	@chief=@request.employee.department.employees.where(role: 2).first
  	if !@chief.nil?
  		chief_email = "#{@chief.nombre} <#{@chief.email}>"
  	else
  		chief_email= ""
  	end
  	# administrator
	@administrator=Employee.where(:department_id => Department.where(:enterprise_id => request.employee.department.enterprise)).where(:role => 3).first
	administrator_email = "#{@administrator.nombre} < #{@administrator.email}>"
  	
  	mail(to: [@request.employee.email, chief_email],cc: administrator_email, subject: subject)
  end

  def nuevo_calendario(calendar) 
    @calendar=calendar
    @url='http://gescalendar.herokuapp.com'
    chief_emails=Array.new
    admins_emails=Array.new
    emp_emails=Array.new

    if(@calendar.status==1)
      subject='Apertura del calendario del año: '+calendar.anio.to_s+' para el departamento '+calendar.department.nombre
    else
      subject='Cierre del calendario del año: '+calendar.anio.to_s+' para el departamento '+calendar.department.nombre
    end
    admins=Employee.where(:role=> 3,:department_id => calendar.department.enterprise.departments)
    admins.each do |admin|
      admins_emails.push(admin.email)
    end

    # chief department
    chiefs=calendar.department.employees.where(role: 2)
    chiefs.each do |chief|
      chief_emails.push(chief.email)
    end
    # employees department
    employees=calendar.department.employees.where(role:1)
    

    employees.each do |emp|
      emp_emails.push(emp.email)
    end


    mail(to: emp_emails.concat(admins_emails.concat(chief_emails)), subject: subject)
  end


end
