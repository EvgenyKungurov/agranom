class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :city
  has_many :phones, dependent: :destroy
  accepts_nested_attributes_for :phones, allow_destroy: true
  delegate :name, to: :city, prefix: true, allow_nil: true
end
