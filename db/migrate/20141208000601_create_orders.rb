class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :username
      t.text :address
      t.string :email
      t.integer :userid
      t.string :status
      t.string :paytype

      t.timestamps
    end
  end
end
