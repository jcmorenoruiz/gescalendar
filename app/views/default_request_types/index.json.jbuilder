json.array!(@default_request_types) do |default_request_type|
  json.extract! default_request_type, :id, :nombre, :num_dias_max, :status
  json.url default_request_type_url(default_request_type, format: :json)
end
