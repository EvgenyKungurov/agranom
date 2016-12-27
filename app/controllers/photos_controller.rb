class PhotosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_photo, except: [:create]
  before_action :user_photo?, except: [:create]

  def create
    @photo = Photo.new(photo_params)
    render json: { message: 'success uploaded', photo_id: @photo.id } if @photo.save
  end

  def destroy
    render json: { message: 'success deleted' } if @photo.destroy
  end

  private

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def user_photo?
    redirect_to root_path unless current_user.id == @photo.user_id
  end

  def photo_params
    params.require(:photo).permit(:image).merge(user_id: current_user.id)
  end
end
