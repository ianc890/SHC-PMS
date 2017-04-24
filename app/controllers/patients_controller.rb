class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_doctor, only: [:create, :destroy, :edit]
  before_action :correct_doctor,   only: [:destroy, :edit]

  # GET /patients
  # GET /patients.json
  def index
  #  @patients = Patient.all
  @patients = Patient.where("doctor_id = ?", current_doctor)
  @patients = @patients.search(params[:search])
  @doctors = Doctor.all
  end

  # GET /patients/1
  # GET /patients/1.json
  def show
    @patient = Patient.find(params[:id])
  end

  # GET /patients/new
  def new
    @patient = Patient.new
    @doctors = current_doctor
  end

  # GET /patients/1/edit
  def edit
    @patient = Patient.find(params[:id])
    @doctors = Doctor.all
  end

  # POST /patients
  # POST /patients.json
  def create
    @patient = Patient.new(patient_params)

    @patient.doctor_id = current_doctor.id if current_doctor

    respond_to do |format|
      if @patient.save
        format.html { redirect_to @patient, notice: 'Patient was successfully created.' }
        format.json { render :show, status: :created, location: @patient }
      else
        format.html { render :new }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patients/1
  # PATCH/PUT /patients/1.json
  def update
    respond_to do |format|
      if @patient.update(patient_params)
        format.html { redirect_to @patient, notice: 'Patient was successfully updated.' }
        format.json { render :show, status: :ok, location: @patient }
      else
        format.html { render :edit }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1
  # DELETE /patients/1.json
  def destroy
    @patient.destroy
    respond_to do |format|
      format.html { redirect_to patients_url, notice: 'Patient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def patient_params
      params.require(:patient).permit(:name, :date_of_birth, :gender, :address, :email, :contact, :doctor_id)
    end

    def correct_doctor
      @patient = current_doctor.patients.find_by(id: params[:id])
      redirect_to patients_path if @patient.nil?
    end
end
