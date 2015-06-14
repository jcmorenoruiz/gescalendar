class Calendar < ActiveRecord::Base
	include Filterable
	has_many :line_calendars

	belongs_to :department , :inverse_of => :calendars
	default_scope { order('anio ASC') }
	scope :status, -> (status) { where status: status}
	scope :department, -> (department_id) { where department_id: department_id } 


	validates :anio, presence: true,length: { is: 4 }, 
	numericality: { only_integer: true}

	validates_uniqueness_of  :anio, scope: :department_id, message: 'El departamento indicado ya tiene un calendario para el año seleccionado.'
	validates :fecha_apertura, presence: true, length: { is: 10}
	validates :status, inclusion: { in: [true,false]}

	validates_date :fecha_apertura,on: :create, :on_or_after => lambda { Date.current}, message: 'La fecha de apertura no puede ser anterior a la fecha actual.'
end
