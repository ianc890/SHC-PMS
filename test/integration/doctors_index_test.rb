require 'test_helper'

class DoctorsIndexTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @admin = doctors(:michael)
    @non_admin = doctors(:archer)
  end

  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get doctors_path
    assert_template 'doctors/index'
    assert_select 'div.pagination'
    first_page_of_doctors = Doctor.paginate(page: 1)
    first_page_of_doctors.each do |doctor|
      assert_select 'a[href=?]', doctor_path(doctor), text: doctor.name
      unless doctor == @admin
        assert_select 'a[href=?]', doctor_path(doctor), text: 'delete'
      end
    end
    assert_difference 'Doctor.count', -1 do
      delete doctor_path(@non_admin)
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get doctors_path
    assert_select 'a', text: 'delete', count: 0
  end
end
