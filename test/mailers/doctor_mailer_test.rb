require 'test_helper'

class DoctorMailerTest < ActionMailer::TestCase

  test "account_activation" do
    doctor = doctors(:michael)
    doctor.activation_token = Doctor.new_token
    mail = DoctorMailer.account_activation(doctor)
    assert_equal "Account activation", mail.subject
    assert_equal [doctor.email], mail.to
    assert_equal ["noreply@shc-pms.com"], mail.from
    assert_match doctor.name,               mail.body.encoded
    assert_match doctor.activation_token,   mail.body.encoded
    assert_match CGI.escape(doctor.email),  mail.body.encoded
  end

  test "password_reset" do
    doctor = doctors(:michael)
    doctor.reset_token = Doctor.new_token
    mail = DoctorMailer.password_reset(doctor)
    assert_equal "Password reset", mail.subject
    assert_equal [doctor.email], mail.to
    assert_equal ["noreply@shc-pms.com"], mail.from
    assert_match doctor.reset_token,        mail.body.encoded
    assert_match CGI.escape(doctor.email),  mail.body.encoded
  end
end
