class Ad < ApplicationRecord
  extend FriendlyId
  include PgSearch
  friendly_id :slug_candidates, use: :slugged
  pg_search_scope :search,
                  against: [:title, :content],
                  using: { tsearch: { prefix: true } }

  belongs_to :user
  belongs_to :category
  belongs_to :location
  has_many :photos, dependent: :destroy

  validates :title, length: { minimum: 6 }, presence: true
  validates :content, :user_id, :category_id, :location_id, :price, presence: true

  before_save :set_expire_day, :set_status, if: :new_record?

  scope :active, -> { where('expire_day >= ?', Time.zone.now).where(status: 1) }
  scope :not_active, -> { where('expire_day < ?', Time.zone.now).or(Ad.where(status: 0)) }

  def slug_candidates
    [title.to_s + '-' + rand.to_s]
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end

  def should_generate_new_friendly_id?
    title_changed? || super
  end

  private

  def set_status
    self.status = 1
  end

  def set_expire_day
    self.expire_day = Time.zone.now + 1.month
  end
end
