json.array!(@payment_types) do |payment_type|
  json.extract! payment_type, :id
  json.url payment_type_url(payment_type, format: :json)
end
