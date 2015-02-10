class Order < ActiveRecord::Base
	has_many :line_items, dependent: :destroy

	validates :username, :address, :email, :address,:address2,
	:telephone1,:telephone2,:shipcountry, presence: true

	validates :accept, acceptance: { accept: true }

	attr_accessible :username, :address,:email,
	:address2,:telephone1,:telephone2,
	:shipcountry,:shipping,:accept,:status,
	:paytype,:bankname,:refernumber,:bankinformation
	
	SHIPPING_OPTION = ["DHL","FEDEX","UPS"]
	PAYMENT_TYPES = [ "Bank Deposit", "Check", "Electronic Transfer"]
	ORDER_STATUS = ["Payment checked, your order has been sent to your ship address"]

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
