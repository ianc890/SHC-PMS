json.array!(@patients) do |patient|
  json.extract! patient, :id, :name, :date_of_Birth, :address, :phone_number, :infection, :injury, :observations, :doctor_id
  json.url patient_url(patient, format: :json)
end
