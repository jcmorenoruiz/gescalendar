class Calendar < ActiveRecord::Base

	belongs_to :enterprise , :inverse_of => :enterprises
	default_scope { order('anio ASC') }

	validates :anio, presence: true,length: { is: 4 }, 
	numericality: { only_integer: true}

	validates_uniqueness_of  :anio, scope: :enterprise_id
	validates :fecha_apertura, presence: true, length: { is: 10}
	validates :status, inclusion: { in: [true,false]}

	validates_date :fecha_apertura, :on_or_after => lambda { Date.current}
end
