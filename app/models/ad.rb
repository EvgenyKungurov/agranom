class Ad < ApplicationRecord
  include PgSearch
  multisearchable against: :title

  belongs_to :user
  belongs_to :category
  has_many :photos, dependent: :destroy

  validates :title, length: { minimum: 6 }, presence: true
  validates :content, :user_id, :category_id, :city_id, :price, presence: true

  before_save :set_expire_day, if: :new_record?
  after_save  :pg_search_rebuild

  scope :active, -> { where('expire_day >= ?', Time.zone.now) }
  scope :not_active, -> { where('expire_day < ?', Time.zone.now) }

  private

  def set_expire_day
    self.expire_day = Time.zone.now + 1.month
  end

  def pg_search_rebuild
    PgSearch::Multisearch.rebuild(self.class)
  end
end
