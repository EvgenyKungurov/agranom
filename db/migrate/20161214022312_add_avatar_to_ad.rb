class AddAvatarToAd < ActiveRecord::Migration[5.0]
  def up
    add_attachment :ads, :avatar
  end

  def down
    remove_attachment :ads, :avatar
  end
end
