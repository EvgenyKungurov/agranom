class Ad < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :photos

  validates :title, length: { minimum: 6 }, presence: true
  validates :content, :user_id, :category_id, :city_id, :price, presence: true

  before_save :set_expire_day

  scope :active, -> { where('expire_day >= ?', Time.zone.now) }
  scope :not_active, -> { where('expire_day < ?', Time.zone.now) }

  private

  def set_expire_day
    self.expire_day = Time.zone.now + 1.month
  end
end
