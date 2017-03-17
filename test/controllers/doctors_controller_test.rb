require 'test_helper'

class DoctorsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @doctor = doctors(:michael)
    @other_doctor = doctors(:archer)
  end

  test "should redirect index when not logged in" do
    get doctors_path
    assert_redirected_to login_url
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get edit_doctor_path(@doctor)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch doctor_path(@doctor), params: { user: { name: @doctor.name,
                                              email: @doctor.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_doctor)
    assert_not @other_doctor.admin?
    patch doctor_path(@other_doctor), params: {
                                    doctor: { password:              "password",
                                            password_confirmation: "password",
                                            admin: true } }
    assert_not @other_doctor.admin?
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_doctor)
    get edit_doctor_path(@doctor)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_doctor)
    patch doctor_path(@doctor), params: { doctor: { name: @doctor.name,
                                              email: @doctor.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Doctor.count' do
      delete doctor_path(@doctor)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_doctor)
    assert_no_difference 'Doctor.count' do
      delete doctor_path(@doctor)
    end
    assert_redirected_to root_url
  end
end
