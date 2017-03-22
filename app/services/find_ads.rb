# Find location and pass this in js
class FindAds
  def initialize(options = {})
    @location_id = Location.friendly.find_by(slug: options[:location_id])&.id
    @category_id = Category.friendly.find_by(slug: options[:category_id])&.id
    @category_with_children =
      Category.find_by(id: @category_id)&.self_and_descendants&.map(&:id)
    @location_with_children =
      Location.find_by(id: @location_id)&.self_and_descendants&.map(&:id)
  end

  def call
    return [] unless @location_id && @category_id
    if @category_id
      Ad.includes(:location, :category).where(
        location_id: @location_with_children
      ).where(category_id: @category_with_children).active
    else
      Ad.includes(:location, :category)
        .where(location_id: @location_with_children).active
    end
  end
end
