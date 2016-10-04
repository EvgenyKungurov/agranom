class AdsController < ApplicationController
  def index
    @categories = Category.roots
  end
end
