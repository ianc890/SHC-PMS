require 'test_helper'

class DoctorsIndexTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @doctor = doctors(:michael)
  end

  test "index including pagination" do
    log_in_as(@doctor)
    get doctors_path
    assert_template 'doctors/index'
    assert_select 'div.pagination'
    Doctor.paginate(page: 1).each do |doctor|
      assert_select 'a[href=?]', doctor_path(doctor), text: doctor.name
    end
  end
end
