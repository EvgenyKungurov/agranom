class DeletePhoneColumnFromProfile < ActiveRecord::Migration[5.0]
  def change
    remove_column :profiles, :phone
  end
end
