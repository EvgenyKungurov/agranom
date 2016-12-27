require 'rails_helper'

RSpec.describe 'Ads', type: :request do
  let!(:user) { FactoryGirl.create :user1 }
  let!(:ad_user1) { user.ads.first }
  let!(:another_user) { FactoryGirl.create :user2 }
  let!(:ad_user2) { another_user.ads.first }
  let!(:ad_params) { FactoryGirl.attributes_for(:ad) }

  def sign_in(user)
    user = { 'user[email]' => user.email, 'user[password]' => user.password }
    post new_user_session_path, params: user
  end

  describe 'GET /ads/all' do
    it 'should be available for all' do
      get ads_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #new' do
    it 'should be available for user' do
      sign_in(user)
      get new_profile_ad_path(user)
      expect(response).to have_http_status(200)
    end

    it 'should not be available for anonymous' do
      get new_profile_ad_path(user.profile)
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'GET #edit' do
    it 'should not be available for other users' do
      sign_in(user)
      get edit_profile_ad_path(user.profile, fake_ad)
      expect(response).to redirect_to root_path(locale: :ru)
    end

    it 'should not be available for anonymous' do
      get edit_profile_ad_path(user.profile, fake_ad)
      expect(response).to redirect_to new_user_session_path
    end

    it 'should be available for user' do
      sign_in(user)
      get edit_profile_ad_path(user.profile, ad)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show' do
    it 'should be available for user' do
      get profile_ad_path(user.profile, ad)
      expect(response).to have_http_status(200)
    end

    it 'should not be available for users' do
      get profile_ad_path(user.profile, ad)
      expect(response).to have_http_status(200)
    end
  end

  describe '#destroy' do
    it 'should not be available for other users' do
      sign_in(user)
      delete '/profiles/ads/#{fake_ad.id}', {}
      expect(response).to redirect_to root_path(locale: :ru)
    end

    it 'should not be available for anonymous' do
      delete "/profiles/ads/#{user.ads.first.id}", {}
      expect(response).to redirect_to new_user_session_path
    end

    it 'should be available to owner of ad' do
      sign_in(user)
      delete "/profiles/ads/#{user.ads.first.id}", {}
      expect(response).to redirect_to profile_ads_path
    end
  end

  describe '#update' do
    it 'should not be available for other users' do
      sign_in(user)
      patch "/profiles/ads/#{fake_ad.id}", {}
      expect(response).to redirect_to root_path(locale: :ru)
    end

    it 'should not be available for anonymous' do
      patch "/profiles/ads/#{fake_ad.id}", {}
      expect(response).to redirect_to new_user_session_path
    end

    it 'should be available to owner of ad' do
      sign_in(user)
      patch "/profiles/ads/#{user.ads.first.id}", ad: ad_params
      expect(page).to have_content article.title
    end
  end

  describe '#create' do
    it 'should not be available for anonymous' do
      post profile_ads_path(user), ad: ad_params
      expect(response).to redirect_to new_user_session_path
    end

    it 'should be available users' do
      sign_in(user)
      post profile_ads_path(user), ad: ad_params
      expect(page).to redirect_to profile_ad_path(current_user.ads.last)
    end
  end
end
