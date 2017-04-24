class RecordsController < ApplicationController
  before_action :logged_in_doctor, only: [:create, :destroy, :edit]
  before_action :find_patient

  def index
    @records = Record.where("patient_id = ?", @patient.id)

    respond_to do |format|
      format.html
      format.csv { send_data @records.to_csv, filename: "#{@patient.name} Records-#{Date.today}.csv" }
    end
  end

  def new
    @record = Record.new
  end

  def create
    @record = Record.new(record_params)

    @record.patient_id = @patient.id

    if @record.save!
      redirect_to patient_record_path(@patient, @record)
    else
      render 'new'
    end
  end

  def show
    @record = Record.find(params[:id])
    @record.patient_id = @patient.id
  end

  def edit
  end

  def show
    @record = Record.find(params[:id])
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def record_params
    params.require(:record).permit(:reason_for_visit, :infection, :injury, :observations, :medications, :patient_id)
  end

  def find_patient
    @patient = Patient.find(params[:patient_id])
  end

end
