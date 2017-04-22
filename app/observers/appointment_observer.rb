class AppointmentObserver < Everett::Observer

#  def after_create(doctor)
  #  Rails.logger.info("#{doctor.name} has been added to the system!")
#  end

  def after_create_commit(appointment)
     AppointmentMailer.appointment_confirmation(appointment).deliver_now
  end

  def after_update_commit(appointment)
     AppointmentMailer.appointment_reschedule(appointment).deliver_now
  end
end
