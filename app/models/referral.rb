class Referral < ApplicationRecord

  belongs_to :patient
  belongs_to :doctor
  belongs_to :hospital

  default_scope -> { order(priority: :asc) }

  validates :patient_id, presence: true
  validates :doctor_id, presence: true
  validates :hospital_id, presence: true
  validates :priority, presence: true
  validates :medical_test, presence: true
  validates :description, presence: true, length: { maximum: 140 }

end
