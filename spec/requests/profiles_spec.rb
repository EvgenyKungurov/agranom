require 'rails_helper'

RSpec.describe 'Profiles', type: :request do
  let!(:country) { FactoryGirl.create(:location, name: 'Россия') }
  let!(:region) do
    FactoryGirl.create(
      :location, name: 'Забайкальский край', parent_id: country.id
    )
  end
  let!(:city) do
    FactoryGirl.create(:location, name: 'Чита', parent_id: region.id)
  end
  let(:user) { FactoryGirl.create(:user, location_id: city.id) }
  let!(:profile_params) do
    FactoryGirl.attributes_for(:profile)
  end
  let!(:fake_profile) { FactoryGirl.create :profile }

  def sign_in(user)
    user = { 'user[email]' => user.email, 'user[password]' => user.password }
    post new_user_session_path, params: user
  end

  describe 'GET #show' do
    it 'should not be available for other user' do
      sign_in(user)
      get profile_path(fake_profile)
      expect(response).to redirect_to root_path(locale: :ru)
    end

    it 'should not be available for anonymous' do
      get profile_path(fake_profile)
      expect(response).to redirect_to new_user_session_path
    end

    it 'should be available for current_user' do
      sign_in(user)
      get profile_path(user.profile)
      expect(response).to have_http_status 200
    end
  end

  describe 'GET #edit' do
    it 'should not be available for other users' do
      sign_in(user)
      get edit_profile_path(fake_profile)
      expect(response).to redirect_to root_path(locale: :ru)
    end

    it 'should not be available for anonymous' do
      get edit_profile_path(user.profile.id)
      expect(response).to redirect_to new_user_session_path
    end

    it 'should be available for current_user' do
      sign_in(user)
      get edit_profile_path(user.profile.id)
      expect(response).to have_http_status 200
    end
  end

  describe '#update' do
    it 'should not be available for other users' do
      sign_in(user)
      patch "/profiles/#{fake_profile.id}", params: profile_params
      expect(response).to redirect_to root_path(locale: :ru)
    end

    it 'should not be available for anonymous' do
      patch "/profiles/#{user.profile.id}"
      expect(response).to redirect_to new_user_session_path
    end

    it 'should be available for current_user' do
      sign_in(user)
      params = { profile: profile_params }.merge(user: { location_id: city.id })
      patch "/profiles/#{user.profile.id}", params: params
      expect(response).to redirect_to profile_path(user.profile.id, locale: :ru)
    end
  end
end
