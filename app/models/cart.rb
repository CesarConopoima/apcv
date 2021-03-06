class Cart < ActiveRecord::Base
	has_many :line_items, dependent: :destroy
	
	def add_product(product_id)
		current_item = line_items.find_by_product_id(product_id)
		if current_item
			current_item.quantity += 1
		else
			current_item = line_items.build(product_id: product_id)
			current_item.quantity += quantity - 1
		end
		current_item
	end
	
	def add_product_quantity(product_id,quantity)
		current_item = line_items.find_by_product_id(product_id)
		if current_item
			current_item.quantity += quantity 
		else
			current_item = line_items.build(product_id: product_id)
			current_item.quantity += quantity - 1
		end
			current_item
	end

	def total_price
		line_items.to_a.sum { |item| item.total_price }
	end
	
	def erase(line_item_id)
		current_item = line_items.find(line_item_id)
		current_item.destroy
		current_item
  	end
end
