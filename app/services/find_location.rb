# Find location and pass this in js
class FindLocation
  attr_reader :type_of_request

  def initialize(options = {})
    @id = options.fetch(:get_id, '')
    @type_of_request = options.fetch(:type_of_request, '')
  end

  def call
    return [] if @id.empty? || @type_of_request.empty?

    if @type_of_request == 'select_region'
      Country.find(@id).regions
    else
      Region.find(@id).cities
    end
  end
end
