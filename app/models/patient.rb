class Patient < ApplicationRecord
  belongs_to :doctor

  validates :infection, length: { maximum: 140 }
  validates :injury, length: { maximum: 140 }
  validates :observations, length: { maximum: 140 }
end
