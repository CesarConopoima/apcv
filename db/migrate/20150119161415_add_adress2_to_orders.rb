class AddAdress2ToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :address2, :string
  	add_column :orders, :telephone1, :string
  	add_column :orders, :telephone2, :string
  	add_column :orders, :shipcountry, :string
  	add_column :orders, :accept, :boolean
  end
end
