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

  def update_slug
    self.slug = name.to_slug.normalize(transliterations: :russian).to_s
  end
end
