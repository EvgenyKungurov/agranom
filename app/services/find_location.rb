# Find location and pass this in js
class FindLocation
  attr_reader :type_of_request

  def initialize(options = {})
    @id = options.fetch(:location_id, '')
  end

  def call
    return [] if @id.empty?

    if Location.find(@id).children_count.positive?
      Location.find(@id).children
    else
      Location.where(id: @id)
    end
  end
end
