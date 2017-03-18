class PasswordResetsController < ApplicationController
  before_action :get_doctor,   only: [:edit, :update]
  before_action :valid_doctor, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]    # Case (1)

  def new

  end

  def create
    @doctor = Doctor.find_by(email: params[:password_reset][:email].downcase)
    if @doctor
      @doctor.create_reset_digest
      @doctor.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end

  def edit

  end

  def update
    if params[:doctor][:password].empty?                  # Case (3)
      @doctor.errors.add(:password, "can't be empty")
      render 'edit'
    elsif @doctor.update_attributes(doctor_params)          # Case (4)
      log_in @doctor
      flash[:success] = "Password has been reset."
      redirect_to @doctor
    else
      render 'edit'                                     # Case (2)
    end
  end

  private

    def doctor_params
      params.require(:doctor).permit(:password, :password_confirmation)
    end

    # Before filters

    def get_doctor
      @doctor = Doctor.find_by(email: params[:email])
    end

    # Confirms a valid doctor.
    def valid_doctor
      unless (@doctor && @doctor.activated? &&
              @doctor.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end

    # Checks expiration of reset token.
    def check_expiration
      if @doctor.password_reset_expired?
        flash[:danger] = "Password reset has expired."
        redirect_to new_password_reset_url
      end
    end
end
