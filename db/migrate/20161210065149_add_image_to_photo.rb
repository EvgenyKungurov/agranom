class AddImageToPhoto < ActiveRecord::Migration[5.0]
  def up
    add_attachment :photos, :image
  end

  def down
    remove_attachment :photos, :image
  end
end
