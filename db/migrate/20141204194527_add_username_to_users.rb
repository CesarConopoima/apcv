class AddUsernameToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :username, :string
  	add_column :users, :companyname, :string
  	add_column :users, :telephone, :string
  	add_column :users, :fax, :string
  end
end
