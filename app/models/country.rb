class Country < ApplicationRecord
  has_many :regions
  validates :name, :short_name, presence: true, length: { minimum: 2, maximum: 50 }
  before_save { self.name = name.capitalize }
  before_save { self.short_name = short_name.upcase }
end
