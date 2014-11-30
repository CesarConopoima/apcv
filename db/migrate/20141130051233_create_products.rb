class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :code
      t.string :marc
      t.integer :quantity
      t.decimal :price
      t.string :imageurl
      t.string :model
      t.string :addedimageurl

      t.timestamps
    end
  end
end
