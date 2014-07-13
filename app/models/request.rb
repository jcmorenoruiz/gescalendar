class Request < ActiveRecord::Base
	enum status: [:denegada,:pendiente,:confirmada]

	belongs_to :employee
	belongs_to :request_type
	
	#default_scope -> { order ('desde DESC')}

	validates :status, presence: true
	validates :desde, presence: true
	validates :hasta, presence: true
	validates_datetime :hasta, :on_or_after => :desde , :on_or_after_message => 'debe ser igual o posterior a la fecha de inicio'

	validates :motivo, length: { maximum: 140 }
	validates :motivo_rev, length: { maximum: 140 }
	validates :employee_id , presence: true
	validates :request_type_id, length: { minimum: 1, message: "Indique el tipo de solicitud" }
    

	# date range validations. (pendientes,confirmadas)
	validates :desde,:hasta,:overlap => 
	{ :scope => "employee_id",
	 :query_options => { :active => nil },
	 :message_content => "Ya existe una solicitud en el periodo solicitado."
	}
	 scope :active, -> { where  status: [1,2] }
	 
	validate :date_same_year, on: :create
	validate :calendar_open, on: :create
	validate :min_disponibilidad, on: :create

	validate :rest_days, on: :create
	# check if rest days for this availability
	def rest_days

		dias_requested=weekdays_in_date_range(desde..hasta)
		rt=RequestType.find(request_type_id)
		dias=0
    requests=Request.joins(:request_type).where(:employee_id => employee_id,status: [1,2],:request_type_id => request_type_id).all.where('extract(year from desde)= ?',"#{desde.year.to_i}")
     
    #working days.
    requests.each do |rq|  
      dias+=weekdays_in_date_range(rq.desde..rq.hasta) 
    end

    if dias_requested>(rt.num_dias_max-dias)
    	errors.add(:desde,"Debe seleccionar un periodo igual o inferior a los días restantes. (#{(rt.num_dias_max-dias).abs} dias)")
    end

	end

	# both dates must be in the same year
	def date_same_year
		if desde.present? && hasta.present? && Date.parse(desde.to_s).year!=Date.parse(hasta.to_s).year
			errors.add(:desde,"No se puede seleccionar un periodo que incluya años diferentes.")
		end
	end

	# check if the calendar is open for requests
	def calendar_open
		cal=Calendar.where(:anio => Date.parse(desde.to_s).year,:department_id => Employee.find(employee_id).department.id).first
		if cal.nil? || cal.status!=true 
				errors.add(:desde,"El calendario para las fechas seleccionadas esta cerrado.")
		end	
	end

	def min_disponibilidad
		# if some day of requests overlaps whith min period availability.
		employee=Employee.find(employee_id)
		av=Availability.where(:department_id => employee.department_id).where('upper(cargo) like ?',"#{employee.cargo.upcase}")
			.where("((desde - ?) * (? - hasta)) >= 0", desde, hasta).where(:status => true)

		if av.count>0 # employees disponibilities	
			av.each do |avail|
			
				employees_on=Employee.where(:department_id => employee.department_id)
					.where('upper(cargo) like ?',"#{employee.cargo.upcase}")
					.where('not exists(select * from requests where ((desde - ?) * (? - hasta)) >= 0 and requests.employee_id=employees.id and status>0)',desde,hasta)

				if employees_on.count<=avail.num_min_emp
					errors.add(:desde,"No es posible realizar la solicitud ya que se ha establecido una disponibilidad mínima en su Departamento de #{avail.num_min_emp} Empleados con cargo: '#{avail.cargo}' durante los días comprendidos entre el #{avail.desde} a #{avail.hasta}")
				end
			end
		end

	end

	 # Check if a given interval overlaps this interval    
  def overlaps?(other)
    ((start_date - other.end_date) * (other.start_date - end_date)) >= 0
  end

   def weekdays_in_date_range(range)
    # You could modify the select block to also check for holidays
    range.select { |d| (1..5).include?(d.wday) }.size
  end


end
