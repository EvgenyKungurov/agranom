require 'rails_helper'

RSpec.describe 'FindCategory' do
  let!(:category) { FactoryGirl.create :category }
  let!(:category_two) { FactoryGirl.create(:category, name: 'Для дачи') }
  let!(:category_two_children) { category_two.children.create!(name: 'Для огорода') }

  describe FindCategory do
    it 'should return all categories without params' do
      result = FindCategory.new.call
      expect(result.categories).to eq Category.all
    end

    it 'should return one category without children' do
      options = { category_id: category.id }
      result = FindCategory.new(options).call
      expect(result.categories.first).to eq category
    end

    it 'should return children collection' do
      options = { category_id: category_two.id }
      result = FindCategory.new(options).call
      children = category_two.children
      expect(result.categories).to eq children
    end
  end
end
