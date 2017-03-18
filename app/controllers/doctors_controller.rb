class DoctorsController < ApplicationController

  before_action :logged_in_doctor, only: [:index, :edit, :update, :destroy]
  before_action :correct_doctor,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @doctors = Doctor.paginate(page: params[:page])
  end

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
      @doctor.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @doctor = Doctor.find(params[:id])
  end

  def update
    @doctor = Doctor.find(params[:id])
    if @doctor.update_attributes(doctor_params)
      # Handle a successful update.
      flash[:success] = "Profile updated"
      redirect_to @doctor
    else
      render 'edit'
    end
  end

  def destroy
    Doctor.find(params[:id]).destroy
    flash[:success] = "Doctor deleted"
    redirect_to doctors_url
  end

  private

    def doctor_params
      params.require(:doctor).permit(:name, :date_of_birth, :job_title, :address, :contact_number, :email, :password,
                                   :password_confirmation)
    end

    # Before filters

    # Confirms a logged-in user.
    def logged_in_doctor
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_doctor
      @doctor = Doctor.find(params[:id])
      redirect_to(root_url) unless current_doctor?(@doctor)
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_doctor.admin?
    end
end
