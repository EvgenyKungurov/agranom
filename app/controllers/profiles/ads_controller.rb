class Profiles::AdsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_ad, except: [:index, :new, :create, :archive]
  before_action :set_locale
  before_action :user_ad?, except: [:index, :new, :create, :archive]
  before_action :set_variables, only: [:edit, :create, :new, :update]

  layout 'profile'

  def index
    @ads = Ad.where(user_id: current_user.id).active
  end

  def archive
    @ads = Ad.where(user_id: current_user.id).not_active
  end

  def new
    @ad = Ad.new
  end

  # GET /ads/1
  # GET /ads/1.json
  def show
  end

  # GET /ads/1/edit
  def edit
  end

  # POST /ads
  # POST /ads.json
  def create
    @ad = Ad.new(ad_params)
    respond_to do |format|
      if @ad.save
        AssignImages.new(@ad.id, params).call
        format.html { redirect_to profile_ad_path(current_user.profile, @ad), notice: 'ad was successfully created.' }
        format.json { render :show, status: :created, location: @ad }
      else
        format.html { render :new }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ads/1
  # PATCH/PUT /ads/1.json
  def update
    respond_to do |format|
      if @ad.update(ad_params)
        AssignImages.new(@ad.id, params).call
        format.html { redirect_to profile_ad_path(current_user.profile, @ad), notice: 'ad was successfully updated.' }
        format.json { render :show, status: :ok, location: @ad }
      else
        format.html { render :edit }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ads/1
  # DELETE /ads/1.json
  def destroy
    @ad.destroy
    respond_to do |format|
      format.html { redirect_to profile_ads_path, notice: 'ad was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_ad
    @ad = Ad.find(params[:id])
  end

  def set_variables
    @ad_images = Photo.where(ad_id: @ad.id) if @ad
    @ad_images ||= Photo.none
    @categories = Category.roots
    @cities = Location.find(current_user.location_id).parent.children
    @countries = Location.roots
  end

  def ad_params
    params.require(:ad).permit(
      :title, :content, :category_id, :location_id,
      :price, :avatar, :category_dump
    ).merge(user_id: current_user.id)
  end

  def user_ad?
    redirect_to root_path unless current_user.id == @ad.user_id
  end
end
