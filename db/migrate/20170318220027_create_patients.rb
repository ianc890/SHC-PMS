class CreatePatients < ActiveRecord::Migration[5.0]
  def change
    create_table :patients do |t|
      t.string :name
      t.date :date_of_birth
      t.string :gender
      t.string :address
      t.string :email
      t.string :contact
      t.references :doctor, foreign_key: true

      t.timestamps
    end
    add_index :patients, [:doctor_id, :created_at]
  end
end
