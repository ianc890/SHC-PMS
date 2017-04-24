class CreateRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :records do |t|
      t.text :reason_for_visit
      t.text :infection
      t.text :injury
      t.text :observations
      t.text :medications
      t.references :patient, foreign_key: true

      t.timestamps
    end
  end
end
