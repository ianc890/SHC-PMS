class CreateHospitals < ActiveRecord::Migration[5.0]
  def change
    create_table :hospitals do |t|
      t.string :hospital_name
      t.string :county

      t.timestamps
    end
  end
end
