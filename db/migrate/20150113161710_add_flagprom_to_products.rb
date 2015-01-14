class AddFlagpromToProducts < ActiveRecord::Migration
  def change
    add_column :products, :flagprom, :string
  end
end
