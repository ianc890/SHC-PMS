class Patient < ApplicationRecord
  has_many :appointments, dependent: :destroy
  belongs_to :doctor

end
