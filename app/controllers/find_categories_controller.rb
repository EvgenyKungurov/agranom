class FindCategoriesController < ApplicationController
  def show
    @result = FindCategory.new(params).call
    @children_count = Category.find(params[:category_id])&.children_count
    render json: { categories: @result, children_count: @children_count }
  end
end
