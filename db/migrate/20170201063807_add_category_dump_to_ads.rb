class AddCategoryDumpToAds < ActiveRecord::Migration[5.0]
  def change
    add_column :ads, :category_dump, :text
  end
end
