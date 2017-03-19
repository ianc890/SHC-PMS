require 'test_helper'

class AppointmentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @doctor = doctors(:michael)
    @patient = patients(:one)
    # This code is not idiomatically correct.
    @appointment = Appointment.new(appointment_date: 28/04/2017, appointment_time: "14:00:00", patient_id: @patient.id, doctor_id: @doctor.id)
  end

  test "should be valid" do
    assert @appointment.valid?
  end

  test "patient id and doctor id should be present" do
    @appointment.patient_id = nil
    @appointment.doctor_id = nil
    assert_not @appointment.valid?
  end

  test "date should be present" do
    @appointment.appointment_date = "   "
    assert_not @appointment.valid?
  end

  test "time should be present" do
    @appointment.appointment_time = "   "
    assert_not @appointment.valid?
  end

end
