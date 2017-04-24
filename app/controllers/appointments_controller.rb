class AppointmentsController < ApplicationController
  before_action :logged_in_doctor, only: [:create, :destroy, :edit]
  before_action :correct_doctor,   only: [:destroy, :edit]

  def index
    @appointments = Appointment.where("doctor_id = ?", current_doctor).decorate
    @patients = Patient.all
    @doctors = Doctor.all
  end

  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.doctor_id = current_doctor.id if current_doctor

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
    @appointment = Appointment.find(params[:id]).decorate
  end

  def new
    @appointment = Appointment.new
    @patients = Patient.all
    @doctors = current_doctor
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
    if @appointment.update_attributes(appointment_params)
      flash[:success] = "Appointment updated"
      redirect_to root_url
    else
      render 'edit'
    end
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
