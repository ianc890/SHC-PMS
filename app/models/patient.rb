class Patient < ApplicationRecord
  has_many :appointments, dependent: :destroy
  has_many :referrals
  has_many :records

  belongs_to :doctor
  default_scope -> { order(created_at: :desc) }

  validates :doctor_id, presence: true
  validates :name, presence: true
  validates :date_of_birth, presence: true
  validates :gender, presence: true
  validates :address, presence: true
  validates :email, presence: true
  validates :contact, presence: true

  GENDER = ["Male", "Female"]

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      all
    end
  end

end
