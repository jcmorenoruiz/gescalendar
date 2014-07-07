module DepartmentsRequestTypesHelper

	def number_departments(request_type)
    DepartmentsRequestType.where(:request_type_id => request_type.id).count
  end
end
