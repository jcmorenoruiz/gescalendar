class DefaultRequestType < ActiveRecord::Base
	include Filterable

	#validates :department_id, presence: true
	default_scope -> { order('nombre asc')}
	scope :status, -> (status) { where status: status}
	scope :starts_with, -> (nombre) { where("nombre like ?", "#{nombre}%")}

	# validations

	validates :nombre, presence: true,length: { maximum: 50 }
	validates :num_dias_max, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 365}

end
