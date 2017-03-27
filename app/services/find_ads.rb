# Find ads
class FindAds
  def initialize(options = {})
    @location_id = Location.friendly.find_by(slug: options[:location_id])&.id
    @category_id = Category.friendly.find_by(slug: options[:category_id])&.id
    @category_with_children =
      Category.find_by(id: @category_id)&.self_and_descendants&.map(&:id)
    @location_with_children =
      Location.find_by(id: @location_id)&.self_and_descendants&.map(&:id)
    @search_query = options[:search]
    @relation = Ad.includes(:location, :category).extending(Scopes)
  end

  def call
    return [] unless @location_id
    @relation.with_query(@search_query)
             .with_location(@location_with_children)
             .with_category(@category_with_children)
             .active
  end

  # Scopes for finding
  module Scopes
    def with_location(location)
      return self unless location
      where(location_id: location)
    end

    def with_category(category)
      return self unless category
      where(category_id: category)
    end

    def with_query(search_query)
      return self if search_query.empty?
      search(search_query)
    end
  end
end
