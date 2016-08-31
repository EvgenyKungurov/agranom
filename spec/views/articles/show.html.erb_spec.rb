require 'rails_helper'

RSpec.describe 'articles/index' do
  def sign_in(user, role = nil)
    user.add_role :admin if role == :admin
    visit '/sign_in'
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end

  let!(:user) { FactoryGirl.create :user }
  let!(:article) { FactoryGirl.create :article }

  describe 'GET #index' do
    it 'renders the index template' do
      visit article_path(article)
      expect(page).to render_template('show')
    end

    it 'users can not see link Edit' do
      visit article_path(article)
      expect(page).not_to have_link :Edit
    end

    it 'admin can see link Edit' do
      sign_in(user, :admin)
      visit article_path(article)
      expect(page).to have_link :Edit
    end
  end
end
