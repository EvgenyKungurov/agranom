class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, length: { minimum: 3 }, presence: true, uniqueness: true
  has_many :ads
  acts_as_nested_set

  before_save   :name_capitalize
  after_create  :parent_count_increase
  after_destroy :parent_count_decrease

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end

  def should_generate_new_friendly_id?
    name_changed? || super
  end
end
