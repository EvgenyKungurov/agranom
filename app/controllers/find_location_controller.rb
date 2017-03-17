class FindLocationController < ApplicationController
  def show
    @result = FindLocation.new(params).call
    @children_count = Location.find(params[:location_id])&.children_count
    @countries = Location.roots
    render json: { locations: @result, children_count: @children_count }
  end
end
