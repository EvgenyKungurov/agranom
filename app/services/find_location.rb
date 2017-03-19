# Find location and pass this in js
class FindLocation
  attr_reader :children_count, :locations

  def initialize(options = {})
    @id = options.fetch(:location_id, '').to_s
    @children_count = Location.find_by_id(@id)&.children_count
  end

  def call
    if @id.empty?
      @locations = []
      return self
    end
    @locations =
      if Location.find(@id).children_count.positive?
        Location.find(@id).children
      else
        Location.where(id: @id)
      end
    self
  end
end
