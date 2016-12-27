require 'rails_helper'

RSpec.describe 'articles/index' do
  let!(:user) { FactoryGirl.create :user }
  let!(:article) { FactoryGirl.create :article }
end
