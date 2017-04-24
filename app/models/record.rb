class Record < ApplicationRecord
  belongs_to :patient

  def self.to_csv
    attributes = %w{id reason_for_visit infection injury observations medications patient_id}

    CSV.generate(headers: true) do |csv|
      csv << attributes

    all.each do |record|
      csv << attributes.map{ |attr| record.send(attr) }
    end
  end
end
end
