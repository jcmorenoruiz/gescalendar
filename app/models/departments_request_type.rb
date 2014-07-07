class DepartmentsRequestType < ActiveRecord::Base
  belongs_to :request_type
  belongs_to :department
end
