class CreateReferrals < ActiveRecord::Migration[5.0]
  def change
    create_table :referrals do |t|
      t.integer :priority
      t.string :medical_test
      t.text :description
      t.string :hospital
      t.references :patient, foreign_key: true
      t.references :doctor, foreign_key: true
      t.references :hospital, foreign_key: true

      t.timestamps
    end
    add_index :referrals, [:doctor_id, :created_at]
  end
end
