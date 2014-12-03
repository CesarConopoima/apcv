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
	
	def self.search(search)  
	     if search  
	      where('name LIKE ? OR code LIKE ? OR marc LIKE ?',"%#{search.upcase}%","%#{search.upcase}%","%#{search.downcase.capitalize}%").limit(10)  
	    else
	      where('imageurl LIKE ?', "logo%").order('created_at DESC').limit(6)
	    end  
  	end 

	def self.marcas
  		find_by_sql("select marc from products group by marc")
  	end
  	def self.copeland
  		find_by_sql("select split_part(name,' ', 1) AS names,count(*) AS number from products where marc = 'Copeland' and flagmis='no' group by names having count(*) > 5 order by names")
  	end
  	def self.carrier
  		find_by_sql("select split_part(name,' ', 1) AS names,count(*) AS number from products where marc = 'Carrier' and flagmis='no' group by names having count(*) > 5 order by names")
  	end
  	def self.bitzer
  		find_by_sql("select split_part(name,' ', 1) AS names,count(*) AS number from products where marc = 'Bitzer' and flagmis='no' group by names order by names")
  	end
end
