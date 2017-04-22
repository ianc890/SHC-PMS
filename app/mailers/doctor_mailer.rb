class DoctorMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.doctor_mailer.account_activation.subject
  #

  def account_activation(doctor)
    @doctor = doctor
    mail to: doctor.email, subject: "Account activation"
  end

  def password_reset(doctor)
    @doctor = doctor
    mail to: doctor.email, subject: "Password reset"
  end

  def notification(doctor)
    @doctor = doctor
    mail to: doctor.email, subject: "Welcome"
  end
end
