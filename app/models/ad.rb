class Ad < ApplicationRecord
  include PgSearch
  pg_search_scope :search, against: [:title, :content]

  belongs_to :user
  belongs_to :category
  has_many :photos, dependent: :destroy

  validates :title, length: { minimum: 6 }, presence: true
  validates :content, :user_id, :category_id, :location_id, :price, presence: true

  before_save :set_expire_day, :set_status, if: :new_record?
  before_save :save_slug_attribute

  scope :active, -> { where('expire_day >= ?', Time.zone.now).where(status: 1) }
  scope :not_active, -> { where('expire_day < ?', Time.zone.now).where(status: 0) }

  def to_param
    "#{id}-#{slug}"
  end

  private

  def set_status
    self.status = 1
  end

  def save_slug_attribute
    self.slug = Translit.convert(title).downcase.split.join('-')
  end

  def set_expire_day
    self.expire_day = Time.zone.now + 1.month
  end
end
