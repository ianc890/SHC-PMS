class AddHospitalsToReferral < ActiveRecord::Migration[5.0]
  def change
    add_column :referrals, :hospital, :string
  end
end
