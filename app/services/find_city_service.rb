# Find city and pass this in js
class FindCityService
  attr_reader :type_of_request

  def initialize(params)
    @id = params.fetch(:get_id, '')
    @type_of_request = params.fetch(:type_of_request, '')
  end

  def find
    return [] if @id.empty? || @type_of_request.empty?

    if @type_of_request == 'select_region'
      Country.find(@id).regions
    else
      Region.find(@id).cities
    end
  end
end
