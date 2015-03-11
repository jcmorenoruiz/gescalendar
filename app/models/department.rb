class Department < ActiveRecord::Base
	include Filterable
	has_many :employees, :inverse_of => :department
	# N-N request_type - department
	has_many :request_types, through: :departments_request_types
	has_many :departments_request_types

	has_many :calendars
	has_many :availabilities

	belongs_to :enterprise , :inverse_of => :departments
	
	#validates :department_id, presence: true
	default_scope { order('nombre ASC') }
	scope :status, -> (status) { where status: status}
	scope :starts_with, -> (nombre) { where("nombre like ?", "#{nombre}%")}

	validates :nombre, presence: true,length: { maximum: 60 }
	
	accepts_nested_attributes_for :employees
	accepts_nested_attributes_for :availabilities
	accepts_nested_attributes_for :request_types
end
