require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  def sign_in(user)
    user = { 'user[email]' => user.email, 'user[password]' => user.password }
    post new_user_session_path, params: user
  end

  let!(:user) { FactoryGirl.create :user }
  let!(:article) { FactoryGirl.create :article }
  let!(:article_params) { FactoryGirl.attributes_for(:article) }

  describe '#create' do
    it 'should not be available for users' do
      sign_in(user)
      post '/articles', params: article_params
      expect(page).to redirect_to root_path(locale: :ru)
    end

    it 'should not be available for anonymous' do
      post '/articles', params: article_params
      expect(page).to redirect_to new_user_session_path
    end
  end

  describe '#destroy' do
    it 'should not be available for users' do
      sign_in(user)
      delete "/articles/#{article.id}"
      expect(page).to redirect_to root_path(locale: :ru)
    end

    it 'should not be available for anonymous' do
      delete "/articles/#{article.id}"
      expect(page).to redirect_to new_user_session_path
    end
  end

  describe '#update' do
    it 'should not be available for users' do
      sign_in(user)
      patch "/articles/#{article.id}"
      expect(page).to redirect_to root_path(locale: :ru)
    end

    it 'should not be available for anonymous' do
      patch "/articles/#{article.id}"
      expect(page).to redirect_to new_user_session_path
    end
  end
end
