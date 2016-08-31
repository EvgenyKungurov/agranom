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
      visit articles_path
      expect(page).to render_template('index')
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

    it 'renders template for admin' do
      sign_in(user, :admin)
      visit new_article_path
      expect(page).to have_content 'New Article'
    end
  end
end
