class Region < ApplicationRecord
  belongs_to :country
  has_many :cities
  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
end
