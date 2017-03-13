require 'rails_helper'

RSpec.describe 'Photos', type: :request do
  let!(:category) { FactoryGirl.create :category }
  let!(:country) { FactoryGirl.create :country }
  let!(:region) { FactoryGirl.create(:region, country_id: country.id) }
  let!(:city) { FactoryGirl.create(:city, region_id: region.id) }
  let!(:user) { FactoryGirl.create(:user, city_id: city.id) }
  let!(:user_photo) { FactoryGirl.create(:photo, user_id: user.id) }
  let!(:user2) { FactoryGirl.create(:user, email: ' test@example.com', city_id: city.id) }
  let!(:image) { { image: fixture_file_upload('public/rspec_test.jpg', 'image/jpg') } }

  def sign_in(user)
    user = { 'user[email]': user.email, 'user[password]': user.password }
    post new_user_session_path, params: user
  end

  describe '#create' do
    context 'anonymous' do
      it 'should not be available' do
        post photos_path
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'logged user' do
      it 'should be available users' do
        sign_in(user)
        post photos_path, params: { photo: { image: image } }
        body = JSON.parse(response.body)
        expect(body['message']).to eq 'success uploaded'
      end
    end
  end

  describe '#destroy' do
    context 'owner' do
      it 'should be available' do
        sign_in(user)
        delete photo_path(user_photo)
        body = JSON.parse(response.body)
        expect(body['message']).to eq 'success deleted'
      end
    end

    context 'anonymous' do
      it 'should not be available' do
        delete photo_path(user_photo)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'not owner' do
      it 'should not be available' do
        sign_in(user2)
        delete photo_path(user_photo)
        expect(response).to redirect_to root_path(locale: :ru)
      end
    end
  end
end
