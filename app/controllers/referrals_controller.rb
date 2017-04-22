class ReferralsController < ApplicationController
  before_action :logged_in_doctor, only: [:create, :destroy, :edit]
  before_action :correct_doctor,   only: [:destroy, :edit]
  before_action :find_patient

  # GET /referrals
  # GET /referrals.json
  def index
    @referrals = Referral.where("patient_id = ?", @patient.id)
    #@patients = Patient.all
  #  @doctors = Doctor.all
  @hospitals = Hospital.all
  end

  # GET /referrals/new
  def new
    @referral = Referral.new
  #  @patients = Patient.new(session[:item_attributes])
  #  @doctors = current_doctor
     @hospitals = Hospital.all
  end

  # POST /referrals
  # POST /referrals.json
  def create
    @referral = Referral.new(referral_params)

    @referral.doctor_id = current_doctor.id if current_doctor

    @referral.patient_id = @patient.id

    # @referral.patient_id = @patients

		if @referral.save!
			redirect_to patient_referral_path(@patient, @referral)
		else
			render 'new'
		end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def referral_params
      params.require(:referral).permit(:priority, :medical_test, :description, :patient_id, :doctor_id, :hospital_id)
    end

    def correct_doctor
      @referral = current_doctor.referrals.find_by(id: params[:id])
      redirect_to referrals_path if @referral.nil?
    end

    def find_patient
      @patient = Patient.find(params[:patient_id])
    end

end
