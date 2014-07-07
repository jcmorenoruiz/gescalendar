class Department < ActiveRecord::Base
	has_many :employees, :inverse_of => :department
	# N-N request_type - department
	has_many :request_types, through: :departments_request_types
	has_many :departments_request_types

	has_many :calendars
	has_many :availabilities

	belongs_to :enterprise , :inverse_of => :departments
	default_scope { order('nombre ASC') }

	validates :nombre, presence: true,length: { maximum: 60 }
	
	accepts_nested_attributes_for :employees
	accepts_nested_attributes_for :availabilities
	accepts_nested_attributes_for :request_types
end
