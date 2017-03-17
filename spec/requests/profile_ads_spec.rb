require 'rails_helper'

RSpec.describe 'Ads', type: :request do
  let!(:category) { FactoryGirl.create :category }
  let!(:country) { FactoryGirl.create(:location, name: 'Россия') }
  let!(:region) do
    FactoryGirl.create(
      :location, name: 'Забайкальский край', parent_id: country.id
    )
  end
  let!(:city) do
    FactoryGirl.create(:location, name: 'Чита', parent_id: region.id)
  end

  let!(:user) { FactoryGirl.create(:user, location_id: city.id) }
  let!(:user_ad) do
    FactoryGirl.create(:ad, user_id: user.id, category_id: category.id)
  end

  let!(:another_user) do
    FactoryGirl.create(:user, email: 'test@ex.com', location_id: city.id)
  end
  let!(:another_user_ad) do
    FactoryGirl.create(:ad, user_id: another_user.id, category_id: category.id)
  end
  let!(:ad_params) do
    { category_id: category.id, location_id: city.id, title: 'Мой заголовок',
      content: 'MyText', price: 1200 }
  end

  def sign_in(user)
    user = { 'user[email]': user.email, 'user[password]': user.password }
    post new_user_session_path, params: user
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
        sign_in(user)
        get profile_ad_path(user.profile, user_ad)
        expect(response).to have_http_status(200)
      end
    end

    context 'not owner' do
      it 'should not be available' do
        get profile_ad_path(user.profile, user_ad)
        expect(response).to redirect_to new_user_session_path
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
        delete profile_ad_path(user, another_user_ad.id), params: {}
        expect(response).to redirect_to root_path(locale: :ru)
      end
    end

    context 'anonymous' do
      it 'should not be available' do
        delete profile_ad_path(user, another_user_ad.id), params: {}
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'owner' do
      it 'should be available' do
        sign_in(user)
        delete profile_ad_path(user, user_ad.id), params: {}
        expect(response).to redirect_to profile_ads_path
      end
    end
  end

  describe '#update' do
    context 'not owner' do
      it 'should not be available' do
        sign_in(user)
        patch profile_ad_path(user, another_user_ad.id), params: {}
        expect(response).to redirect_to root_path(locale: :ru)
      end
    end

    context 'anonymous' do
      it 'should not be available' do
        patch profile_ad_path(user, another_user_ad.id), params: {}
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'owner' do
      it 'should be available' do
        sign_in(user)
        patch profile_ad_path(user, user_ad.id), params: { ad: ad_params }
        expect(response).to redirect_to profile_ad_path(
          user.profile.id, user.ads.last, locale: :ru
        )
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
        expect(response).to redirect_to profile_ad_path(
          user.profile.id, user.ads.last, locale: :ru
        )
      end
    end
  end
end
