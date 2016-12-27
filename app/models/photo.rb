class Photo < ApplicationRecord
  belongs_to :ad
  belongs_to :user

  has_attached_file :image, styles:
                          { medium: '800x800>', thumb: '200x200>' },
                            default_url: '/images/:style/missing.png'

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates_with AttachmentSizeValidator, attributes: :image, less_than: 1.megabytes
end
