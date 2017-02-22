class AdsController < ApplicationController
  before_action :set_ad, except: [:index, :search]
  before_action :set_locale

  def index
    @categories = Category.roots
  end

  def search
  end

  # GET /ads/1
  # GET /ads/1.json
  def show
  end

  private

  def set_ad
    @ad = Ad.find(params[:id])
  end
end
