# Find city and pass this in js
class FindCityService
  def initialize(params)
    @id = params.fetch :get_id
    @type_of_request = params.fetch :type_of_request
  end

  def type_of_request
    @type_of_request.nil? ? [] : @type_of_request.first.class.to_s.downcase
  end

  def find
    return [] if @id.empty? || @action.empty?
    case @action
    when 'select_country'
      Country.find(@id).regions
    when 'select_region'
      Region.find(@id).cities
    end
  end
end
