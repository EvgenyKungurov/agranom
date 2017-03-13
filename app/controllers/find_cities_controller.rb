class FindCitiesController < ApplicationController
  def show
    @find_city_service = FindLocation.new(params)
    @result = @find_city_service.call
    @type_of_request = @find_city_service.type_of_request
    @countries = Country.all
  end
end
