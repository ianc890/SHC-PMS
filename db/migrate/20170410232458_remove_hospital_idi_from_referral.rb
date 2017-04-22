class RemoveHospitalIdiFromReferral < ActiveRecord::Migration[5.0]
  def change
    remove_reference :referrals, :hospital, foreign_key: true
  end
end
