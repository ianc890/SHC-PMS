require 'test_helper'

class DoctorsSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'Doctor.count' do
      post doctors_path, params: { doctor: { name:  "",
                                         date_of_birth: "",
                                         job_title: "",
                                         address: "",
                                         contact_number: "",
                                         email: "doctor@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'doctors/new'
    # assert_select 'div#<CSS id for error explanation>'
    # assert_select 'div.<CSS class for field with error>'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'Doctor.count', 1 do
      post doctors_path, params: { doctor: { name:  "Example Doctor",
                                         date_of_birth: "21/10/1985",
                                         job_title: "Surgeon",
                                         address: "40 Fake Street",
                                         contact_number: "0851234567",
                                         email: "doctor@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'doctors/show'
  end
end
