class AdsController < ApplicationController
  before_action :set_locale

  def index
    @categories = Category.roots.map(&:self_and_descendants).flatten
    @countries  = Location.roots
    if search_params[:location_id]
      @location = Location.where(slug: search_params[:location_id])
    end
    @result = FindAds.new(search_params).call
  end

  # GET /ads/1
  # GET /ads/1.json
  def show
    @ad = Ad.friendly.find(search_params[:id])
  end

  def search
    location = Location.friendly.find_by(id: search_params[:location_id])
    if search_params[:category_id]
      category = Category.friendly.find_by(id: search_params[:category_id])
    end
    redirect_to ads_path(location, category, search: search_params[:search])
  end

  private

  def search_params
    params.permit(:location_id, :category_id, :search, :id)
  end
end
