require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

  def setup
    @doctor = doctors(:michael)
    remember(@doctor)
  end

  test "current_user returns right user when session is nil" do
    assert_equal @doctor, current_doctor
    assert is_logged_in?
  end

  test "current_user returns nil when remember digest is wrong" do
    @doctor.update_attribute(:remember_digest, Doctor.digest(Doctor.new_token))
    assert_nil current_doctor
  end
end
