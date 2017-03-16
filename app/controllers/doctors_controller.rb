class DoctorsController < ApplicationController

  def new
    @doctor = Doctor.new
  end

  def show
    @doctor = Doctor.find(params[:id])
  end

  def create
    @doctor = Doctor.new(doctor_params)    # Not the final implementation!
    if @doctor.save
      # Handle a successful save
      log_in @doctor
      flash[:success] = "Welcome to the Smart-Health-Care App!"
      redirect_to @doctor
    else
      render 'new'
    end
  end

  private

    def doctor_params
      params.require(:doctor).permit(:name, :date_of_birth, :job_title, :address, :contact_number, :email, :password,
                                   :password_confirmation)
    end
end
