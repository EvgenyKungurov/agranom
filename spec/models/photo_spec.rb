require 'rails_helper'

RSpec.describe Photo, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:ad) }
  it { should have_attached_file(:image) }
  it do
    should validate_attachment_content_type(:image)
      .allowing('image/png', 'image/jpg', 'image/jpeg')
      .rejecting('text/plain', 'text/xml')
  end
  it { should validate_attachment_size(:image).less_than(1.megabytes) }
end
