class AddAdminToDoctors < ActiveRecord::Migration[5.0]
  def change
    add_column :doctors, :admin, :boolean, default: false
  end
end
