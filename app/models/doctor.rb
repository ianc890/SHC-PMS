class Doctor < ApplicationRecord
  has_many :patients

  validates name, presence: true
  validates date_of_birth, presence: true
  validates job_title, presence: true
  validates address, presence: true
  validates contact_number, presence: true
  validates email, presence: true
end
