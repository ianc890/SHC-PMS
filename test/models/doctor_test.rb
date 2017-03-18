require 'test_helper'

class DoctorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @doctor = Doctor.new(name: "Example Doctor", date_of_birth: 28/04/1971, job_title: "Family Doctor", address: "40 Fake Street", contact_number: "085-1234567", email: "doctor@example.com", password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @doctor.valid?
  end

  test "name should be present" do
    @doctor.name = "     "
    assert_not @doctor.valid?
  end

  test "email should be present" do
    @doctor.email = "     "
    assert_not @doctor.valid?
  end

  test "name should not be too long" do
    @doctor.name = "a" * 51
    assert_not @doctor.valid?
  end

  test "email should not be too long" do
    @doctor.email = "a" * 244 + "@example.com"
    assert_not @doctor.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[doctor@example.com DOCTOR@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @doctor.email = valid_address
      assert @doctor.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[doctor@example,com doctor_at_foo.org doctor.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @doctor.email = invalid_address
      assert_not @doctor.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_doctor = @doctor.dup
    duplicate_doctor.email = @doctor.email.upcase
    @doctor.save
    assert_not duplicate_doctor.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @doctor.email = mixed_case_email
    @doctor.save
    assert_equal mixed_case_email.downcase, @doctor.reload.email
  end

  test "password should be present (nonblank)" do
    @doctor.password = @doctor.password_confirmation = " " * 6
    assert_not @doctor.valid?
  end

  test "password should have a minimum length" do
    @doctor.password = @doctor.password_confirmation = "a" * 5
    assert_not @doctor.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @doctor.authenticated?(:remember, '')
  end
end
