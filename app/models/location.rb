class Location < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  validates :name, presence: true, length: { minimum: 2, maximum: 30 }
  acts_as_nested_set

  has_many :ads

  before_save   :name_capitalize
  after_create  :parent_count_increase
  after_destroy :parent_count_decrease

  def slug_candidates
    [:name, [:name, :parent_id]]
  end

  def should_generate_new_friendly_id?
    name_changed? || super
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end
end
