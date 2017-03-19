class FindCategoriesController < ApplicationController
  def show
    @result = FindCategory.new(params).call
    render json: {
      categories: @result.categories, children_count: @result.children_count
    }
  end
end
