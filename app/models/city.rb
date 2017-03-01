class City < ApplicationRecord
  belongs_to :region
  has_one :country, through: :region
  has_many :profiles
  validates :name, presence: true, length: { minimum: 2, maximum: 30 }
end
