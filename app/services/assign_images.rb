# Assign ad id for images
class AssignImages
  def initialize(ad_id, options = {})
    @ad_id = ad_id
    @images_id = options.fetch :uploaded_images
  end

  def call
    photos = Photo.where(id: @images_id.split(','))
    photos.map { |photo| photo.update_attributes(ad_id: @ad_id) }
  end
end
