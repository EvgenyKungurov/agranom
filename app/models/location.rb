class Location < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, presence: true, length: { minimum: 2, maximum: 30 }
  acts_as_nested_set

  has_many :ads

  before_save   :name_capitalize, :update_slug
  after_create  :parent_count_increase
  after_destroy :parent_count_decrease

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end

  def slug_candidates
    [
      :name,
      [:name, :parent_id]
    ]
  end
end
