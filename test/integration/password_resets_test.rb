require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
    @doctor = doctors(:michael)
  end

  test "password resets" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    # Invalid email
    post password_resets_path, params: { password_reset: { email: "" } }
    assert_not flash.empty?
    assert_template 'password_resets/new'
    # Valid email
    post password_resets_path,
         params: { password_reset: { email: @doctor.email } }
    assert_not_equal @doctor.reset_digest, @doctor.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_url
    # Password reset form
    doctor = assigns(:doctor)
    # Wrong email
    get edit_password_reset_path(doctor.reset_token, email: "")
    assert_redirected_to root_url
    # Inactive doctor
    doctor.toggle!(:activated)
    get edit_password_reset_path(doctor.reset_token, email: doctor.email)
    assert_redirected_to root_url
    doctor.toggle!(:activated)
    # Right email, wrong token
    get edit_password_reset_path('wrong token', email: doctor.email)
    assert_redirected_to root_url
    # Right email, right token
    get edit_password_reset_path(doctor.reset_token, email: doctor.email)
    assert_template 'password_resets/edit'
    assert_select "input[name=email][type=hidden][value=?]", doctor.email
    # Invalid password & confirmation
    patch password_reset_path(doctor.reset_token),
          params: { email: doctor.email,
                    doctor: { password:              "foobaz",
                            password_confirmation: "barquux" } }
    assert_select 'div#error_explanation'
    # Empty password
    patch password_reset_path(doctor.reset_token),
          params: { email: doctor.email,
                    doctor: { password:              "",
                            password_confirmation: "" } }
    assert_select 'div#error_explanation'
    # Valid password & confirmation
    patch password_reset_path(doctor.reset_token),
          params: { email: doctor.email,
                    doctor: { password:              "foobaz",
                            password_confirmation: "foobaz" } }
    assert is_logged_in?
    assert_not flash.empty?
    assert_redirected_to doctor
  end
end
