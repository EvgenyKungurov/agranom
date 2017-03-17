# Find categories and pass this in js
class FindCategory
  def initialize(options = {})
    @id = options.fetch(:category_id, '')
  end

  def call
    return Category.all if @id.empty?

    if Category.find(@id).children_count.positive?
      Category.find(@id).children
    else
      Category.where(id: @id)
    end
  end
end
