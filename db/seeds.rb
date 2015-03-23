# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
default_calendars = [
  [ 1,"2014",'t' ],
  [ 2,"2015",'t' ]
]

default_line_calendars = [
  [ "2014-01-01", "Año nuevo", 1, 't' ],
  [ "2014-01-06", "Epifanía del Señor", 1, 't' ],
  [ "2014-04-18", "Viernes Santo", 1, 't' ],
  [ "2014-05-01", "Dia del trabajador", 1 ,'t'],
  [ "2014-10-13", "Día de la Hispanidad", 1, 't' ],
  [ "2014-11-01", "Todos los Santos", 1, 't' ],
  [ "2014-12-06", "Día de la constitución española", 1, 't'],
  [ "2014-12-08", "La inmaculada Concepción", 1, 't'],
  [ "2014-12-25", "Navidad", 1, 't' ],

  [ "2015-01-01", "Año nuevo", 2, 't' ],
  [ "2015-01-06", "Epifanía del Señor", 2, 't' ],
  [ "2015-04-03", "Viernes Santo", 2, 't' ],
  [ "2015-05-01", "Dia del trabajador", 2 ,'t'],
  [ "2015-10-12", "Día de la Hispanidad", 2, 't' ],
  [ "2015-11-01", "Todos los Santos", 2, 't' ],
  [ "2015-12-06", "Día de la constitución española", 2, 't'],
  [ "2015-12-08", "La inmaculada Concepción", 2, 't'],
  [ "2015-12-25", "Navidad", 2, 't' ],
]

default_request_types = [
  [ "Vacaciones", 22,'t' ],
  [ "Asuntos Propios", 2,'t' ],
  [ "Cambio de domicilio", 1,'t' ],
  [ "Boda",10,'t' ],
]

# Enterprises
enterprises=[
  ["Confort Systems","t"],
  ["Hybrid Auctions","t"],
]

# Departments
departments=[
  ["Gerencia","t",1],
  ["Sede Malaga","t",1],
  ["Sede Madrid","t",1],
  ["Gerencia","t",2],
  ["Departamento Técnico","t",2],
  ["Departamento de Finanzas","t",2]
]

# Employees

employees=[
["Juan Carlos Moreno","jcmorenoruiz@gmail.com","jcmoreno",3,"2014-07-13","t","Administrador",1],
["Antonio Robles","antonio@gmail.com","jcmoreno",2,"2014-07-13","t","Jefe Técnico",2],
["Jose Luis","jose@gmail.com","jcmoreno",1,"2014-07-13","t","Técnico Mantenimiento",2],
["Adolfo Rodriguez","adolfo@gmail.com","jcmoreno",1,"2014-07-13","t","Técnico Instalaciones",2],
["Salvador Allende","salva@gmail.com","jcmoreno",1,"2014-07-11","t","Técnico Instalaciones",2],
["Eva Maria Gamez","eva@gmail.com","jcmoreno",2,"2014-08-07","t","Jefe Técnico",3],
["Guti Sanchez","guti@gmail.com","jcmoreno",1,"2015-04-01","t","Técnico Instalaciones",3],
["Alfredo Sanchez","alfredosanchez@gmail.com","jcmoreno",1,"2015-03-01","t","Técnico Instalaciones",3],
["Santiago Gomez","santigomez@gmail.com","jcmoreno",3,"2015-01-01","t","Administrador",3],
["Carlos Romero","konin85@gmail.com","jcmoreno",1,"2012-01-25","t","Técnico Mantenimiento",2],
]




# requests

 # desde-hasta-status-rt-empleado
requests=[
  ["2015-03-30","2015-04-05",2,1,1],
  ["2015-06-22","2015-07-05",2,1,1],
  ["2015-04-06","2015-04-19",2,1,2],
  ["2015-08-03","2015-08-16",2,1,2],
  ["2015-08-17","2015-08-17",2,2,2],
  ["2015-07-01","2015-01-01",2,2,1],
  ["2015-05-10","2015-05-30",2,1,4],
  ["2015-06-01","2015-06-02",2,1,4],
  ["2015-08-07","2015-08-16",2,1,3],
  ["2015-09-01","2015-09-13",2,1,3],
  ["2015-06-12","2015-06-12",2,2,3],
]



colors=["#1a6e2b","#5e2913","#de1b28","#faa07a"]

default_calendars.each do |id, anio, status|
  DefaultCalendar.create( id: id, anio: anio, status: status)
end

default_line_calendars.each do |fecha, nombre, default_calendar_id,status|
  DefaultLineCalendar.create( fecha: fecha, nombre: nombre, 
    default_calendar_id: default_calendar_id, status: status )
end

default_request_types.each do |nombre, num_dias_max,status|
  DefaultRequestType.create( nombre: nombre, num_dias_max: num_dias_max, status: status)
end


enterprises.each do |empresa,status |
  obj=Enterprise.create( empresa: empresa, status: status)
  default_request_types.each do |nombre, num_dias_max, status|
      obj.request_types.build(:nombre => nombre,:num_dias_max => num_dias_max,:status => status,:tipo => true,:color => colors.pop)
      obj.save()
    end
end

departments.each do |nombre,status,enterprise_id|
  dpto=Department.create( nombre: nombre, 
    status: status, enterprise_id: enterprise_id )

  rts=RequestType.where(enterprise_id: enterprise_id);
  rts.each do |rt|
    dpto.departments_request_types.build(:num_max_dias => rt.num_dias_max, :request_type_id => rt.id)
    dpto.save()
  end  

   cal=Calendar.create(anio:  "2015",fecha_apertura: Date.today, status: "t", department_id: dpto.id,d1: 't', d2: 't', d3: 't',d4: 't',d5: 't',d6: 't',d7: 't')

   lines=DefaultCalendar.where(anio: cal.anio).first
   
   if !lines.nil?
      
      lines=lines.default_line_calendars
      # assign default line calendars for year.
      lines.each do |line|
      
        cal.line_calendars.build(:fecha => line.fecha,:dia => line.nombre,:status => line.status)
      end


     if cal.valid?
        cal.save()
        puts "guardado"
    else
       cal.errors.each do |e|
          puts e
        end
    end

   end
   
end

employees.each do |nombre,email,password,role,fecha_alta,status,cargo,department_id|
  Employee.create( nombre: nombre, email: email, password: password, role: role, fecha_alta: fecha_alta, status: status, cargo: cargo, department_id: department_id)
end


requests.each do |desde,hasta,status,request_type_id,employee_id |
  Request.create(:desde => desde, :hasta => hasta, :status => status, :request_type_id => request_type_id, :employee_id => employee_id)
end







