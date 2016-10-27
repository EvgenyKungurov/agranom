class CreateCities < ActiveRecord::Migration[5.0]
  def change
    create_table :cities do |t|
      t.string :name
      t.belongs_to :region, index: true
      t.timestamps
    end
  end
end
