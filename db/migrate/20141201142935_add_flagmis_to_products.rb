class AddFlagmisToProducts < ActiveRecord::Migration
  def change
  	 add_column :products, :flagmis, :string
  end
end
