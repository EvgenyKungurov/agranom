class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :city
  has_many :phones
  accepts_nested_attributes_for :phones, allow_destroy: true
  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :city_id, presence: true
end
