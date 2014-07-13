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
  [ "Vacaciones", 30,'t' ],
]




# Enterprises
enterprises=[
  [1,"Grupo Costa del Sol","t"],
  [2,"Confort Systems","t"],
]

# Departments
departments=[
  [1,"Gerencia","t",1],
  [2,"Sede Malaga","t",1],
  [3,"Sede Madrid","t",1],
  [4,"Gerencia","t",2],
  [5,"Sede Malaga","t",2],
  [6,"Sede Madrid","t",2]
]

# Employees

employees=[
[1,"Juan Carlos Moreno","jc@gmail.com","$2a$10$giibIg22SHcAmwPMVFcGZedlrFM1IDONZSuEi4OnDW/xkWhPcXY06",3,"2014-07-13","t","Jefe",1],
[2,"Antonio Robles","antonio@gmail.com","$2a$10$giibIg22SHcAmwPMVFcGZedlrFM1IDONZSuEi4OnDW/xkWhPcXY06",2,"2014-07-13","t","Jefe Técnico",2],
[3,"Jose Luis","jose@gmail.com","$2a$10$giibIg22SHcAmwPMVFcGZedlrFM1IDONZSuEi4OnDW/xkWhPcXY06",1,"2014-07-13","t","Técnico Mantenimiento",2],
[4,"Adolfo Rodriguez","adolfo@gmail.com","$2a$10$giibIg22SHcAmwPMVFcGZedlrFM1IDONZSuEi4OnDW/xkWhPcXY06",1,"2014-07-13","t","Técnico Instalaciones",2],
[5,"Salvador Allende","salva@gmail.com","$2a$10$giibIg22SHcAmwPMVFcGZedlrFM1IDONZSuEi4OnDW/xkWhPcXY06",1,"2014-07-11","t","Técnico Instalaciones",2],
]



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


#enterprises.each do |id, empresa,status |
 # Enterprise.create( id: id, empresa: empresa, status: status)
#end

#departments.each do |id,nombre,status,enterprise_id|
 # Department.create( id: id, nombre: nombre, 
  #  status: status, enterprise_id: enterprise_id )
#end

#employees.each do |id,nombre,email,password,role,fecha_alta,status,cargo,department_id|
 # Employee.create( id: id, nombre: nombre, email: email, password: password, role: role, fecha_alta: fecha_alta, status: status, cargo: cargo, department_id: department_id)

#end







