class AddUniqToCategorySlug < ActiveRecord::Migration[5.0]
  def change
    add_index :categories, :slug, unique: true
  end
end
