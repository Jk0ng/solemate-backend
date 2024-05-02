class CreateShoes < ActiveRecord::Migration[6.1]
  def change
    create_table :shoes do |t|
      t.string :name
      t.integer :price
      t.text :description
      t.text :image

      t.timestamps
    end
  end
end
