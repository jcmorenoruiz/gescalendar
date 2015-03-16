class RequestType < ActiveRecord::Base
	include Filterable

	has_many :departments, through: :departments_request_types
	has_many :departments_request_types,  :class_name => "DepartmentsRequestType"
	has_many :requests
	belongs_to :enterprise

	#default_scope  { where(status: true)}
	default_scope { order('nombre asc') }
	scope :status, -> (status) { where status: status}
	scope :starts_with, -> (nombre) { where("nombre like ?", "#{nombre}%")}

	validates :nombre, presence: true,length: { maximum: 50 }
	validates :num_dias_max, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 365}
#	validates :color, presence: true

	accepts_nested_attributes_for :departments
end