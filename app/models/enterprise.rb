class Enterprise < ActiveRecord::Base
	has_many :departments, :inverse_of => :enterprise
	has_many :request_types, :inverse_of => :enterprise

	validates :empresa, presence: true, length: { maximum: 100 }
	accepts_nested_attributes_for :departments
end
