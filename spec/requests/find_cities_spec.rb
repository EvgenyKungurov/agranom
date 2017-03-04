require 'rails_helper'

RSpec.describe 'FindCities', type: :request do
  describe '#show' do
    it 'should return 200' do
      get find_city_path, xhr: true
      expect(response).to have_http_status 200
    end
  end
end
