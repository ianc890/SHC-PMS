class AddIndexToDoctorsEmail < ActiveRecord::Migration[5.0]
  def change
    add_index :doctors, :email, unique: true
  end
end
