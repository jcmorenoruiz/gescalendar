class Availability < ActiveRecord::Base
	belongs_to :department
	

	validates :num_min_emp, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 199}
	validates :cargo, presence: true,length: { maximum: 50 }
	validates_date :desde, :on_or_after => lambda { Date.current}, :on_or_after_message => 'La fecha inicial no puede ser anterior a la actual'
	validates_date :hasta, :on_or_after => lambda { Date.current},  :on_or_after_message => 'La fecha inicial no puede ser anterior a la actual'
	validates :notas, length: { maximum: 140 }

	validates_datetime :hasta, :on_or_after => :desde , :on_or_after_message => 'debe ser igual o posterior a la fecha de inicio'
	# date range validations. (pendientes,confirmadas)
	validates :desde,:hasta,:overlap =>
	{
		:scope => "department_id",
		:scope => "cargo",
		:message_content => "Ya existe un periodo de disponibilidad en las fechas indicadas para el mismo cargo"
	}
	#validate :check_overlaps_cargo_department, on: :create
	#validate :edit_overlaps_cargo_department, on: :update

	def check_overlaps_cargo_department
		# if some day of availabilityes overlaps whith new period availability.	
		av=Availability.where(:department_id => department_id).where('upper(cargo) like ?',"#{cargo.upcase}")
			.where("((desde - ?) * (? - hasta)) >= 0", hasta, desde).where(:status => true)

		if av.count>0 # availabilit
					errors.add(:cargo," Ya existe un periodo de disponibilidad mínima para el cargo: '#{cargo}' cuyas fechas coinciden.")	
		end
	end

	def edit_overlaps_cargo_department
		# if some day of availabilityes overlaps whith new period availability.	
		av=Availability.where(:department_id => department_id).where('upper(cargo) like ?',"#{cargo.upcase}")
			.where("((desde - ?) * (? - hasta)) >= 0", hasta, desde).where(:status => true).where('id != ?',id)

		if av.count>0 # availabilit
					errors.add(:cargo," Ya existe un periodo de disponibilidad mínima para el cargo: '#{cargo}' cuyas fechas coinciden.")	
		end
	end



end
