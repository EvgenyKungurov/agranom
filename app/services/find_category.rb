# Find categories and pass this in js
class FindCategory
  attr_reader :category_id

  def initialize(options = {})
    @category_id = options.fetch(:category_id, '')
  end

  def call
    return Category.all if @category_id.empty?

    if Category.find(@category_id).children.size.zero?
      Category.where(id: @category_id)
    else
      Category.find(@category_id).children
    end
  end
end
