class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

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
