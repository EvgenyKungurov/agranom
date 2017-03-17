class Category < ApplicationRecord
  validates :name, length: { minimum: 3 }, presence: true, uniqueness: true
  has_many :ads
  acts_as_nested_set

  before_save   :name_capitalize, :save_slug_attribute
  after_create  :parent_count_increase
  after_destroy :parent_count_decrease

  def to_param
    "#{id}-#{slug}"
  end

  private

  def save_slug_attribute
    self.slug = Translit.convert(name).downcase.split.join('-')
  end

  def name_capitalize
    self.name = name.capitalize
  end

  def parent_count_increase
    parent&.update_attributes(children_count: parent.children_count + 1)
  end

  def parent_count_decrease
    parent&.update_attributes(children_count: parent.children_count - 1)
  end
end
