class Product < ActiveRecord::Base
	validates :name, :code, :marc,:quantity, :price,:imageurl,:model,:flagmis, presence: true
	validates :price, numericality: {greater_than_or_equal_to: 0.1}
	validates :code, uniqueness: true
	validates :imageurl, allow_blank: true, format: {
		with: %r{\.(gif|jpg|png)$}i,
		message: 'La imagen debe tener extension JPG,GIF o PNG'
		}
	MISCELANEUS = [ "no", "si" ]	
	attr_accessible :name, :code, :marc, :quantity, :price, :imageurl, :model,:flagmis,:addedimageurl
	
	def self.marcas
  		find_by_sql("select marc from products group by marc")
  	end
end
