class AddCommonToUsers < ActiveRecord::Migration
  def change
    add_column :users, :common, :boolean
  end
end
