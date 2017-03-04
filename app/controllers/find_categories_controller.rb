class FindCategoriesController < ApplicationController
  def show
    @categories = FindCategory.new(params).call
    render json: { categories: @categories }
  end
end
