class AppointmentMailer < ApplicationMailer

  def appointment_confirmation(appointment)
    @appointment = appointment
    mail to: appointment.patient.email, subject: "Appointment Confirmation"
  end

  def appointment_reschedule(appointment)
    @appointment = appointment
    mail to: appointment.patient.email, subject: "Appointment Reschedule"
  end
end
