class Country < ApplicationRecord
  has_many :regions
  validates :name, :short_name, presence: true, length: { minimum: 2, maximum: 50 }
  before_save :name_capitalize, :short_name_upcase

  private

  def name_capitalize
    self.name = name.capitalize
  end

  def short_name_upcase
    self.short_name = short_name.upcase
  end
end
