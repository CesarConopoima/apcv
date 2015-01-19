class AddAdress2ToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :address2, :string
  	add_column :orders, :address2, :string
  end
end
