class Availability < ActiveRecord::Base
	belongs_to :department
	
	validates :num_min_emp, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 199}
	validates :cargo, presence: true,length: { maximum: 40 }, uniqueness: { case_sensitive: false}
	validates_date :desde, :on_or_after => lambda { Date.current}
	validates_date :hasta, :on_or_after => lambda { Date.current}
	validates :notas, length: { maximum: 140 }

	# date range validations. (cargo)
	validates :desde,:hasta,:overlap => 
	{ :scope => "cargo",
	 :query_options => { :active => nil },
	 :message_content => "Ya existe un Periodo de Disponibilidad Mínima para el cargo solicitado.."
	}
 scope :active, -> { where  status: 1 }


	validates_datetime :hasta, :on_or_after => :desde , :on_or_after_message => 'debe ser igual o posterior a la fecha de inicio'

end
