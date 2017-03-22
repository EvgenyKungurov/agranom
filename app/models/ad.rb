class Ad < ApplicationRecord
  extend FriendlyId
  include PgSearch
  friendly_id :slug_candidates, use: :slugged
  pg_search_scope :search, against: [:title, :content]

  belongs_to :user
  belongs_to :category
  belongs_to :location
  has_many :photos, dependent: :destroy

  validates :title, length: { minimum: 6 }, presence: true
  validates :content, :user_id, :category_id, :location_id, :price, presence: true

  before_save :set_expire_day, :set_status, if: :new_record?

  scope :active, -> { where('expire_day >= ?', Time.zone.now).where(status: 1) }
  scope :not_active, -> { where('expire_day < ?', Time.zone.now).or(Ad.where(status: 0)) }

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end

  def slug_candidates
    [id.to_s + '-' + title]
  end

  private

  def update_slug
    self.slug = id + '-' + title.to_slug.normalize(transliterations: :russian).to_s
  end

  def set_status
    self.status = 1
  end

  def set_expire_day
    self.expire_day = Time.zone.now + 1.month
  end
end
