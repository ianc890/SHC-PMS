class CreateDoctors < ActiveRecord::Migration[5.0]
  def change
    create_table :doctors do |t|
      t.string :name
      t.date :date_of_birth
      t.string :job_title
      t.string :address
      t.string :contact_number
      t.string :email

      t.timestamps
    end
  end
end
