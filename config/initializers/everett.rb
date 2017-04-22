Everett.configure do |config|
  # Activate observers that should always be running.
  # config.observers = :my_observer
  config.observers = :doctor_observer, :appointment_observer
end
