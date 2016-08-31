require 'rails_helper'

RSpec.feature 'Articles', type: :feature do
  def sign_in(user, role = nil)
    user.add_role :admin if role == :admin
    visit '/sign_in'
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end

  let!(:user) { FactoryGirl.create :user }
  let!(:article) { FactoryGirl.create :article }
  let!(:article_params) { FactoryGirl.attributes_for(:article) }

  describe 'GET #new' do
    it 'should not be available for users' do
      sign_in(user)
      visit new_article_path
      expect(current_path).to eq root_path
    end

    it 'should not be available for anonymous' do
      visit new_article_path
      expect(current_path).to eq new_user_session_path
    end
  end

  describe 'GET #edit' do
    it 'should not be available for users' do
      sign_in(user)
      visit edit_article_path(article.id)
      expect(current_path).to eq root_path
    end

    it 'should not be available for anonymous' do
      visit edit_article_path(article.id)
      expect(current_path).to eq new_user_session_path
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
      visit new_article_path
      expect(current_path).to eq root_path
    end

    it 'should not be available for anonymous' do
      visit new_article_path
      expect(current_path).to eq new_user_session_path
    end

    it 'can only admin' do
      sign_in(user, :admin)
      visit new_article_path
      fill_in 'Title', with: article.title
      fill_in 'Content', with: article.content
      click_button 'Create Article'
      expect(current_path).to eq article_path(article.id + 1)
    end
  end

  describe '#destroy' do
    it 'should not be available for users' do
      sign_in(user)
      page.driver.submit :delete, "/articles/#{article.id}", {}
      expect(current_path).to eq root_path
    end

    it 'should not be available for anonymous' do
      page.driver.submit :delete, "/articles/#{article.id}", {}
      expect(current_path).to eq new_user_session_path
    end

    it 'can only admin' do
      sign_in(user, :admin)
      page.driver.submit :delete, "/articles/#{article.id}", {}
      expect(current_path).to eq  articles_path
    end
  end

  describe '#update' do
    it 'should not be available for users' do
      sign_in(user)
      page.driver.submit :patch, "/articles/#{article.id}", {}
      expect(current_path).to eq root_path
    end

    it 'should not be available for anonymous' do
      page.driver.submit :patch, "/articles/#{article.id}", {}
      expect(current_path).to eq new_user_session_path
    end

    it 'can only admin' do
      sign_in(user, :admin)
      page.driver.submit :patch, "/articles/#{article.id}", article: article_params
      expect(page).to have_content article.title
    end
  end
end
