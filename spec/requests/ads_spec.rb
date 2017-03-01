require 'rails_helper'

RSpec.describe 'Ads', type: :request do
  let!(:category) { FactoryGirl.create :category }
  let!(:user) { FactoryGirl.create :user }
  let!(:user_ad) do
    FactoryGirl.create(:ad, user_id: user.id, category_id: category.id)
  end
  let!(:another_user) { FactoryGirl.create(:user, email: 'test@ex.com') }
  let!(:another_user_ad) do
    FactoryGirl.create(:ad, user_id: user.id, category_id: category.id)
  end
  let!(:ad_params) { FactoryGirl.attributes_for(:ad) }

  def sign_in(user)
    user = { 'user[email]': user.email, 'user[password]': user.password }
    post new_user_session_path, params: user
  end

  describe 'GET /ads/all' do
    it 'should be available for all' do
      get ads_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #new' do
    context 'user logged' do
      it 'should be available' do
        sign_in(user)
        get new_profile_ad_path(user)
        expect(response).to have_http_status(200)
      end
    end

    context 'anonymous' do
      it 'should not be available' do
        get new_profile_ad_path(user.profile)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET #show' do
    context 'owner' do
      it 'should be available' do
        get profile_ad_path(user.profile, user_ad)
        expect(response).to have_http_status(200)
      end
    end

    context 'not owner' do
      it 'should not be available' do
        get profile_ad_path(user.profile, user_ad)
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET #edit' do
    context 'not owner' do
      it 'should not be available' do
        sign_in(user)
        get edit_profile_ad_path(user.profile, another_user_ad)
        expect(response).to redirect_to root_path(locale: :ru)
      end
    end

    context 'anonymous' do
      it 'should not be available' do
        get edit_profile_ad_path(user.profile, another_user_ad)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'owner' do
      it 'should be available' do
        sign_in(user)
        get edit_profile_ad_path(user.profile, user_ad)
        expect(response).to have_http_status(200)
      end
    end
  end

  describe '#destroy' do
    context 'not owner' do
      it 'should not be available' do
        sign_in(user)
        delete '/profiles/ads/#{another_user_ad.id}', params: {}
        expect(response).to redirect_to root_path(locale: :ru)
      end
    end

    context 'anonymous' do
      it 'should not be available' do
        delete "/profiles/ads/#{user.ads.first.id}", params: {}
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'owner' do
      it 'should be available' do
        sign_in(user)
        delete "/profiles/ads/#{user.ads.first.id}", params: {}
        expect(response).to redirect_to profile_ads_path
      end
    end
  end

  describe '#update' do
    context 'not owner' do
      it 'should not be available' do
        sign_in(user)
        patch "/profiles/ads/#{another_user_ad.id}", params: {}
        expect(response).to redirect_to root_path(locale: :ru)
      end
    end

    context 'anonymous' do
      it 'should not be available' do
        patch "/profiles/ads/#{another_user_ad.id}", params: {}
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'owner' do
      it 'should be available' do
        sign_in(user)
        patch "/profiles/ads/#{user.ads.first.id}", params: { ad: ad_params }
        expect(page).to have_content article.title
      end
    end
  end

  describe '#create' do
    context 'anonymous' do
      it 'should not be available' do
        post profile_ads_path(user), params: { ad: ad_params }
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'logged user' do
      it 'should be available users' do
        sign_in(user)
        post profile_ads_path(user), params: { ad: ad_params }
        expect(page).to redirect_to profile_ad_path(current_user.ads.last)
      end
    end
  end
end
