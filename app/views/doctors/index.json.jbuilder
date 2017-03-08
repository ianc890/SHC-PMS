json.array!(@doctors) do |doctor|
  json.extract! doctor, :id, :name, :date_of_birth, :job_title, :address, :contact_number, :email
  json.url doctor_url(doctor, format: :json)
end
