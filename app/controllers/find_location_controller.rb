class FindLocationController < ApplicationController
  def show
    @result = FindLocation.new(params).call
    @countries = Location.roots
    render json: {
      locations: @result.locations, children_count: @result.children_count
    }
  end
end
