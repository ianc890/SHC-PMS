module SessionsHelper
  # Logs in the given user.
  def log_in(doctor)
    session[:doctor_id] = doctor.id
  end

  # Remembers a user in a persistent session.
  def remember(doctor)
    doctor.remember
    cookies.permanent.signed[:doctor_id] = doctor.id
    cookies.permanent[:remember_token] = doctor.remember_token
  end

  # Returns true if the given user is the current user.
  def current_doctor?(doctor)
    doctor == current_doctor
  end

  # Returns the current logged-in user (if any).
  def current_doctor
    if (doctor_id = session[:doctor_id])
      @current_doctor ||= Doctor.find_by(id: doctor_id)
    elsif (doctor_id = cookies.signed[:doctor_id])
      doctor = Doctor.find_by(id: doctor_id)
      if doctor && doctor.authenticated?(cookies[:remember_token])
        log_in doctor
        @current_doctor = doctor
      end
    end
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_doctor.nil?
  end

  # Forgets a persistent session.
  def forget(doctor)
    doctor.forget
    cookies.delete(:doctor_id)
    cookies.delete(:remember_token)
  end

  # Logs out the current user.
  def log_out
    forget(current_doctor)
    session.delete(:doctor_id)
    @current_doctor = nil
  end

  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
