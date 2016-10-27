class Category < ApplicationRecord
  has_many :ads
  acts_as_nested_set
end
