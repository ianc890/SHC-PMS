module SessionsHelper
  # Logs in the given user.
  def log_in(doctor)
    session[:doctor_id] = doctor.id
  end

  # Returns the current logged-in user (if any).
  def current_doctor
    @current_doctor ||= Doctor.find_by(id: session[:doctor_id])
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_doctor.nil?
  end

  # Logs out the current user.
  def log_out
    session.delete(:doctor_id)
    @current_doctor = nil
  end
end
