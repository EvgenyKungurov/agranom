class CreateContries < ActiveRecord::Migration[5.0]
  def change
    create_table :contries do |t|
      t.string :name
      t.timestamps
    end
  end
end
