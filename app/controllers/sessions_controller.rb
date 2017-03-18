class SessionsController < ApplicationController

  def new
    
  end

  def create
    doctor = Doctor.find_by(email: params[:session][:email].downcase)
    if doctor && doctor.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      if doctor.activated?
        log_in doctor
        params[:session][:remember_me] == '1' ? remember(doctor) : forget(doctor)
        redirect_back_or doctor
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      # Create an error message
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
