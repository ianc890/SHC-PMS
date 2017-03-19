class AppointmentsController < ApplicationController
  before_action :logged_in_doctor, only: [:create, :destroy, :edit]
  before_action :correct_doctor,   only: [:destroy, :edit]

  def index
    @appointments = Appointment.all
    @patients = Patient.all
    @doctors = Doctor.all
  end

  def create
    @patients = Patient.all
    if @appointment.save
      flash[:success] = "Appointment created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def show
    @appointment = Appointment.find(params[:id])
  end

  def new
    @appointment = Appointment.new
    @patients = Patient.all
    @doctors = Doctor.all
  end

  def destroy
    @appointment.destroy
    flash[:success] = "Appointment deleted"
    redirect_to request.referrer || root_url
  end

  def edit
    @appointment = Appointment.find(params[:id])
    @patients = Patient.all
  end

  def update
    @appointment = Appointment.find(params[:id])
    @patients = Patient.all
  end

  private

    def appointment_params
      params.require(:appointment).permit(:appointment_date, :appointment_time, :patient_id, :doctor_id)
    end

    def correct_doctor
      @appointment = current_doctor.appointments.find_by(id: params[:id])
      redirect_to root_url if @appointment.nil?
    end
end
