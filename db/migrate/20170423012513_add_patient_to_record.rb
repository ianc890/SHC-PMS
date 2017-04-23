class AddPatientToRecord < ActiveRecord::Migration[5.0]
  def change
    add_reference :records, :patient, foreign_key: true
  end
end
