class Phone < ApplicationRecord
  belongs_to :profile
  validates :number, presence: true, length: { minimum: 2, maximum: 50 }
end
