class Order < ActiveRecord::Base
	has_many :line_items, dependent: :destroy

	validates :username, :address, :email, :paytype, presence: true

	validates :accept, acceptance: { accept: true }

	attr_accessible :username, :address,:email,
	:paytype,:address2,
	:telephone1,:telephone2,
	:shipcountry,:shipping,:accept
	
	SHIPPING_OPTION = ["DHL","FEDEX","UPS"]

	def self.orders(user)
		where("userid = ?",user)
	end

	def add_line_items_from_cart(cart)
		cart.line_items.each do |item|
		item.cart_id = nil
		line_items << item
		end
	end
end
