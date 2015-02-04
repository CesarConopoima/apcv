class AddAttachedimgToProducts < ActiveRecord::Migration
  def self.up
    add_attachment :products, :attachedimg
  end

  def self.down
    remove_attachment :products, :attachedimg
  end
end
