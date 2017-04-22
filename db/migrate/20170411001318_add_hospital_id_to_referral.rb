class AddHospitalIdToReferral < ActiveRecord::Migration[5.0]
  def change
    add_reference :referrals, :hospital, foreign_key: true
  end
end
