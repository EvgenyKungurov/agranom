class CategoriesController < ApplicationController
  def index
    @root_categories = Category.roots
  end

  def new
    @category = Category.new
  end
end
