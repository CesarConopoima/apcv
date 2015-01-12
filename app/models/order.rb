class Order < ActiveRecord::Base
	has_many :line_items, dependent: :destroy

	validates :username, :address, :email, :paytype, presence: true
	# validates :username,:presence => { :message => "Este campo debe ser llenado" }
	# validates :address, :presence  => { :message => "Este campo debe ser llenado" }
	# validates :email, :presence => { :message => "Este campo debe ser llenado" }
	# validates :paytype, :presence => { :message => "Este campo debe ser llenado" }

	def add_line_items_from_cart(cart)
		cart.line_items.each do |item|
		item.cart_id = nil
		line_items << item
		end
	end
end
