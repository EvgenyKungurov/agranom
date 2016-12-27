class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  before_action :user_profile?, except: [:new, :find_city]

  def find_city
    @find_city_service = FindCityService.new(params)
    @result = @find_city_service.find
    @type_of_request = @find_city_service.type_of_request

    respond_to do |format|
      format.js {}
    end
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    @progress_bar = ProgressBar.new(@profile).call
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
    @profile.phones.build if @profile.phones.empty?
    @countries, @city, @region = EditCityService.new(@profile).vars
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    @countries = Country.all
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_profile
    @profile = Profile.where(user_id: current_user.id).first
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def profile_params
    params.require(:profile).permit(
      :name, :city_id, phones_attributes: [:id, :number, :country_code, :profile_id]
    )
  end

  def user_profile?
    redirect_to root_path unless current_user.profile.id == @profile.id
  end
end
