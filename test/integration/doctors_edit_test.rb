require 'test_helper'

class DoctorsEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @doctor = doctors(:michael)
  end

  test "unsuccessful edit" do
    log_in_as(@doctor)
    get edit_doctor_path(@doctor)
    assert_template 'doctors/edit'
    patch doctor_path(@doctor), params: { doctor: { name:  "",
                                              date_of_birth: "02/06/1982",
                                              job_title: "Family Doctor",
                                              address: "20 Main Street",
                                              contact_number: "0897654321",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }

    assert_template 'doctors/edit'
  end

  test "successful edit with friendly forwarding" do
    get edit_doctor_path(@doctor)
    log_in_as(@doctor)
    assert_redirected_to edit_doctor_url(@doctor)
    name  = "Foo Bar"
    date_of_birth = "30/03/1971"
    job_title = "Neurologist"
    address = "45 Main Street"
    contact_number = "0871256882"
    email = "foo@bar.com"
    patch doctor_path(@doctor), params: { doctor: { name:  name,
                                              date_of_birth: date_of_birth,
                                              job_title: job_title,
                                              address: address,
                                              contact_number: contact_number,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @doctor
    @doctor.reload
    assert_equal name,  @doctor.name
    assert_equal email, @doctor.email
  end
end
