class AdsController < ApplicationController
  before_action :set_ad, except: [:index, :search]
  before_action :set_locale

  def index
    @categories = Category.roots
    # Ad.search
  end

  # GET /ads/1
  # GET /ads/1.json
  def show
    Ad.search(params[:search]).where(search_params)
    redirect_to ads_path
  end

  def search
    type_of_request = search_params.fetch(:type_of_request)
    get_id = search_params.fetch(:location_id)
    location = Translit.convert()
    category = Translit.convert(search_params.fetch(:category_id))
    redirect_to ads_path(location, category)
  end

  private

  def set_ad
    @ad = Ad.find(params[:id])
  end

  def search_params
    params.permit(:location_id, :category_id, :type_of_request)
  end
end
