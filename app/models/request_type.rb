class RequestType < ActiveRecord::Base
	belongs_to :calendar

	validates :nombre, presence: true,length: { maximum: 50 }
	validates :num_dias_max, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 365}
end