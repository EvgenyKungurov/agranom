class CategoriesController < ApplicationController
  def index
    @root_categories = Categories.roots
  end

  def new
    @category = Category.new
  end
end
