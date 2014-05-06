class Department < ActiveRecord::Base
	has_many :employees, :inverse_of => :department
	has_many :calendars, :inverse_of => :department 
	belongs_to :enterprise , :inverse_of => :departments
	default_scope { order('nombre ASC') }

	validates :nombre, presence: true,length: { maximum: 60 }
	
	accepts_nested_attributes_for :employees
end
