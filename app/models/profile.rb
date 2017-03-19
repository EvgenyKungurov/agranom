class Profile < ApplicationRecord
  belongs_to :user
  accepts_nested_attributes_for :user, update_only: true
end
