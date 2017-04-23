class CreateRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :records do |t|
      t.content :infection
      t.content :injury
      t.content :observations
      t.content :medications

      t.timestamps
    end
  end
end
