class AdsController < ApplicationController
  before_action :set_locale

  def index
    @categories = Category.roots.map(&:self_and_descendants).flatten
    @countries  = Location.roots
    @current_country = current_country.id
    if search_params[:location_id]
      @location = Location.where(slug: search_params[:location_id])
    end
    @ads = FindAds.new(search_params).call.page(params[:page]).per(10)
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

  def current_country
    country = { ru: 'Россия', cn: 'Китай' }
    country_name = country[params[:locale].to_sym]
    Location.find_by_name(country_name)
  end

  def search_params
    params.permit(:location_id, :category_id, :search, :id)
  end
end
