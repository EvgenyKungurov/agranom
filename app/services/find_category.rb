# Find categories and pass this in js
class FindCategory
  attr_reader :categories, :children_count

  def initialize(options = {})
    @id = options.fetch(:category_id, '').to_s
    @children_count = Category.find_by_id(@id)&.children_count
  end

  def call
    if @id.empty?
      @categories = Category.all
      return self
    end
    @categories =
      if Category.find(@id).children_count.positive?
        Category.find(@id).children
      else
        Category.where(id: @id)
      end
    self
  end
end
