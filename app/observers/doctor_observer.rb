class DoctorObserver < Everett::Observer

#  def after_create(doctor)
  #  Rails.logger.info("#{doctor.name} has been added to the system!")
#  end

  def after_create_commit(doctor)
    DoctorMailer.account_activation(doctor).deliver_now
  end

  # def after_update_commit(doctor)
    # woDoctorMailer.notification(doctor).deliver_now
  # end
end
