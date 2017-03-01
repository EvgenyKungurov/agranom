class Category < ApplicationRecord
  include PgSearch
  multisearchable against: :name

  validates :name, length: { minimum: 3 }, presence: true

  has_many :ads
  acts_as_nested_set

  after_save :pg_search_rebuild

  private

  def pg_search_rebuild
    PgSearch::Multisearch.rebuild(self.class)
  end
end
