class ReportsController < ApplicationController

  def index
    @date_from = 7.days.ago.to_date.to_s
    @date_to = Date.today.to_s
    @appointments  = current_doctor.appointments.decorate
    @appointments = Appointment.where('appointment_date BETWEEN ? AND ?', 7.days.ago.to_date.to_s, Date.today.to_s)
  end

  def daily
    @date_to = Date.today.to_s
    @appointments  = current_doctor.appointments.decorate
    @appointments = Appointment.where('appointment_date BETWEEN ? AND ?', Date.today.to_s, Date.today.to_s)
  end

end
