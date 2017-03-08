class CreatePatients < ActiveRecord::Migration[5.0]
  def change
    create_table :patients do |t|
      t.string :name
      t.date :date_of_Birth
      t.string :address
      t.string :phone_number
      t.text :infection
      t.text :injury
      t.text :observations
      t.integer :doctor_id

      t.timestamps
    end
  end
end
