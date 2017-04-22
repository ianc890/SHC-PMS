class RemoveHospitalFromReferral < ActiveRecord::Migration[5.0]
  def change
    remove_column :referrals, :hospital, :string
  end
end
