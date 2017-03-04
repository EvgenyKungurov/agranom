require 'rails_helper'

RSpec.describe 'FindCategory' do
  let!(:category) { FactoryGirl.create :category }
  let!(:category_two) { FactoryGirl.create :category }
  let!(:category_two_children) { category_two.children.create!(name: 'child') }

  describe FindCategory do
    it 'should return all categories without params' do
      result = FindCategory.new.call.first
      expect(result).to be_an_instance_of Category
    end

    it 'should return one category without children' do
      options = { category_id: category.id.to_s }
      result = FindCategory.new(options).call.first
      expect(result).to eq category
    end

    it 'should return children collection' do
      options = { category_id: category_two.id.to_s }
      result = FindCategory.new(options).call.first
      children = category_two.children.first
      expect(result).to eq children
    end
  end
end
