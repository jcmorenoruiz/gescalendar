class DefaultCalendar < ActiveRecord::Base
	include Filterable
	
	has_many :default_line_calendars

	default_scope { order('anio DESC') }
	scope :status, -> (status) { where status: status}

	validates :anio, presence: true,length: { is: 4 }, 
	numericality: { only_integer: true}
	validates_uniqueness_of  :anio 
	validates :status, inclusion: { in: [true,false]}
end
