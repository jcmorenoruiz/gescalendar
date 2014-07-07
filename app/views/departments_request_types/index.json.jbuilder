json.array!(@departments_request_types) do |departments_request_type|
  json.extract! departments_request_type, :id, :num_max_dias, :request_type_id, :department_id
  json.url departments_request_type_url(departments_request_type, format: :json)
end
