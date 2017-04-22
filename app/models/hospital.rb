class Hospital < ApplicationRecord

  has_many :referrals

  default_scope -> { order(county: :asc) }


  validates :hospital_name, presence: true
  validates :county, presence: true

  COUNTY = ["Antrim", "Armagh", "Carlow", "Cavan", "Clare", "Cork", "Derry", "Donegal", "Down",
    "Dublin", "Fermanagh", "Galway", "Kerry", "Kildare", "Kilkenny", "Laois", "Leitrim", "Limerick",
    "Longford", "Louth", "Mayo", "Meath", "Monaghan", "Offaly", "Roscommon", "Sligo", "Tipperary",
    "Tyrone", "Waterford", "Westmeath", "Wexford", "Wicklow"]

    def self.to_csv
      attributes = %w{id hospital_name county}

      CSV.generate(headers: true) do |csv|
        csv << attributes

      all.each do |hospital|
        csv << attributes.map{ |attr| hospital.send(attr) }
      end
    end
  end

  def name
    "#{first_name} #{last_name}"
  end

end
