class Location < ApplicationRecord
  validates :name, presence: true, length: { minimum: 2, maximum: 30 }
  acts_as_nested_set

  before_save   :name_capitalize
  after_create  :parent_count_increase
  after_destroy :parent_count_decrease

  private

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
