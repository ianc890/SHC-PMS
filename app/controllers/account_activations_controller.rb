class AccountActivationsController < ApplicationController

  def edit
    doctor = Doctor.find_by(email: params[:email])
    if doctor && !doctor.activated? && doctor.authenticated?(:activation, params[:id])
      doctor.activate
      log_in doctor
      flash[:success] = "Account activated!"
      redirect_to doctor
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
