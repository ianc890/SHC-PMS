json.array!(@appointments) do |appointment|
  json.extract! appointment, :id, :appointment_date, :appointment_time, :doctor_id, :patient_id
  json.url appointment_url(appointment, format: :json)
end
