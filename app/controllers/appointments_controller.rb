class AppointmentsController < ApplicationController
  before_action :logged_in_doctor, only: [:create, :destroy, :edit]
  before_action :correct_doctor,   only: [:destroy, :edit]

  def index
    @appointments = Appointment.order('appointment_date DESC').decorate
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

      # put your own credentials here
      account_sid = 'AC1d8c3971dfa6dbcd21a881aa3950d098'
      auth_token = '1c97ace2b5e7bac04e12c06402672986'

      # set up a client to talk to the Twilio REST API
      @client = Twilio::REST::Client.new account_sid, auth_token

      @client.account.messages.create({
        :from => '+353861801236',
        :to => '+353857773255',
        :body => 'Appointment created!',
      })
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
