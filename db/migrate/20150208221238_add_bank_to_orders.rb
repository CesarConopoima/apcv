class AddBankToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :bankname, :string
  	add_column :orders, :refernumber, :string
  	add_column :orders, :bankinformation, :text
  end
end
