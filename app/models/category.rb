class Category < ApplicationRecord
  validates :name, length: { minimum: 3 }, presence: true
  has_many :ads
  acts_as_nested_set
end
