require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  def sign_in(user, role = nil, session_type = nil)
    user.add_role :admin if role == :admin
    if session_type == :rspec
      user = { 'user[email]' => user.email, 'user[password]' => user.password }
      post new_user_session_path, params: user
    else
      visit '/sign_in'
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'Log in'
    end
  end

  let(:user) { FactoryGirl.create :user }
  let(:article) { FactoryGirl.create :article }
  let(:article_params) { FactoryGirl.attributes_for(:article) }

  describe 'GET #index' do
    it 'available' do
      get articles_path
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get articles_path
      expect(response).to render_template('index')
    end

    ['Edit', 'New Article', 'Destroy'].each do |action|
      it "users can not see link to #{action}" do
        article
        visit articles_path
        expect(page).not_to have_link action
      end
    end

    ['Edit', 'New Article', 'Destroy'].each do |action|
      it "admin can see link to #{action}" do
        sign_in(user, :admin)
        article
        visit articles_path
        expect(page).to have_link action
      end
    end
  end

  describe 'GET #new' do
    it 'should not be available for users' do
      sign_in(user)
      get new_article_path
      expect(response).to redirect_to new_user_session_path
    end

    it 'should not be available for anonymous' do
      get new_article_path
      expect(response).to redirect_to new_user_session_path
    end

    it 'renders template for admin' do
      sign_in(user, :admin)
      visit new_article_path
      expect(page).to have_content 'New Article'
    end
  end

  describe 'GET #edit' do
    it 'should not be available for users' do
      sign_in(user)
      get edit_article_path(article.id)
      expect(response).to redirect_to new_user_session_path
    end

    it 'should not be available for anonymous' do
      get edit_article_path(article.id)
      expect(response).to redirect_to new_user_session_path
    end

    it 'renders template for admin' do
      sign_in(user, :admin)
      visit edit_article_path(article.id)
      expect(page).to have_content 'Editing Article'
    end
  end

  describe '#create' do
    it 'should not be available for users' do
      sign_in(user)
      post '/articles', params: article_params
      expect(page).to redirect_to new_user_session_path
    end

    it 'should not be available for anonymous' do
      post '/articles', params: article_params
      expect(page).to redirect_to new_user_session_path
    end

    it 'create only admin' do
      sign_in(user, :admin, :rspec)
      post '/articles', article: article_params
      follow_redirect!
      expect(response).to render_template(:show)
    end
  end

  describe '#destroy' do
    it 'should not be available for users' do
      sign_in(user)
      delete "/articles/#{article.id}"
      expect(page).to redirect_to new_user_session_path
    end

    it 'should not be available for anonymous' do
      delete "/articles/#{article.id}"
      expect(page).to redirect_to new_user_session_path
    end

    it 'create only admin' do
      sign_in(user, :admin, :rspec)
      delete "/articles/#{article.id}"
      follow_redirect!
      expect(response).to render_template(:index)
    end
  end

  describe '#update' do
    it 'should not be available for users' do
      sign_in(user)
      patch "/articles/#{article.id}"
      expect(page).to redirect_to new_user_session_path
    end

    it 'should not be available for anonymous' do
      patch "/articles/#{article.id}"
      expect(page).to redirect_to new_user_session_path
    end

    it 'create only admin' do
      sign_in(user, :admin, :rspec)
      patch "/articles/#{article.id}", article: article_params
      follow_redirect!
      expect(response).to render_template(:show)
    end
  end
end
