class Product < ActiveRecord::Base
	has_many :line_items
	before_destroy :ensure_not_referenced_by_any_line_item

	validates :name, :code, :marc,:quantity, :price,:imageurl,:model,:flagmis, presence: true
	validates :price, numericality: {greater_than_or_equal_to: 0.1}
	validates :code, uniqueness: true

	validates :imageurl, allow_blank: true, format: {
		with: %r{\.(gif|jpg|png)$}i,
		message: 'La imagen debe tener extension JPG,GIF o PNG'
		}
	has_attached_file :attachedimg, styles: {
	    thumb: '100x100>',
	    square: '200x200#',
	    medium: '300x300>'
  	}

  	validates_attachment_content_type :attachedimg, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]




	MISCELANEUS = [ "no", "si" ]
	PROMOTION = [ "si", "no" ]	
	attr_accessible :name, :code, :marc, :quantity, :price, :imageurl, :model,:flagmis,:attachedimg,:flagprom
	
	def self.search(search)  
	     if search  
	     	if search.include?("copeland") or search.include?("Copeland") 
	     		@product = search.gsub("copeland","").gsub("Copeland","")
	     		where('name LIKE ? and marc LIKE ?',"%#{@product.upcase}k%","Copeland",)  
	     	elsif search.include?("carrier") or search.include?("Carrier")
	     		@product = search.gsub("carrier","").gsub("Carrier","")
	     		where('name LIKE ? and marc LIKE ?',"%#{@product.upcase}%","Carrier",)  
	     	elsif search.include?("bitzer") or search.include?("Bitzer")
	     		@product = search.gsub("bitzer","").gsub("Bitzer","")
	     		where('name LIKE ? and marc LIKE ?',"%#{@product.upcase}%","Bitzer",)  
	     	elsif search.include?("york") or search.include?("York")
	     		@product = search.gsub("york","").gsub("York","")
	     		where('name LIKE ? and marc LIKE ?',"%#{@product.upcase}%","York",)  
	     	elsif search.include?("trane") or search.include?("Trane")
	     		@product = search.gsub("trane","").gsub("Trane","")
	     		where('name LIKE ? and marc LIKE ?',"%#{@product.upcase}%","Trane",)  
	     	else
	     		where('name LIKE ? OR code LIKE ?',"%#{search.upcase}%","%#{search.upcase}%").limit(8)
	   		end
	   	#aqui el porDefault Seran los productos que tengan mayor volumen de ventas
	   	#eso lo escojera el administrador de la pag
	    else
	      #where('imageurl LIKE ?', "logo%").order('created_at DESC').limit(8)
	      where('imageurl NOT LIKE ? and flagprom LIKE ?', "logo%","si").limit(8)
	    end  
  	end 


	def self.marcas
  		find_by_sql("select marc from products group by marc order by marc")
  	end
  	def self.copeland
  		find_by_sql("select split_part(name,' ', 1) AS names,count(*) AS number from products where marc = 'Copeland' and flagmis='no' group by names having count(*) > 1 order by names")
  	end
  	def self.carrier
  		find_by_sql("select split_part(name,' ', 1) AS names,count(*) AS number from products where marc = 'Carrier' and flagmis='no' group by names having count(*) > 1 order by names")
  	end
  	def self.bitzer
  		find_by_sql("select split_part(name,' ', 1) AS names,count(*) AS number from products where marc = 'Bitzer' and flagmis='no' group by names order by names")
  	end
  	def self.trane
  		find_by_sql("select split_part(name,' ', 1) AS names,count(*) AS number from products where marc = 'Trane' and flagmis='no' group by names order by names")
  	end
  	def self.york
  		find_by_sql("select split_part(name,' ', 1) AS names,count(*) AS number from products where marc = 'York' and flagmis='no' group by names order by names")
  	end

  	def self.detailproduct(name,brand)
  		find_by_sql("select * from products where name like '#{name}%' and marc like '#{brand}' ")
  	end
  	def self.detailproductlist(brand)
  		find_by_sql("select split_part(name,' ', 1) AS names,count(*) AS number from products where marc ='#{brand}' group by names order by names")
  	end
  	def self.findproductbycode(code)
  		where("code = ?",code)
  	end

 	 	
private

	# ensure that there are no line items referencing this product
	def ensure_not_referenced_by_any_line_item
		if line_items.empty?
			return true
		else
			errors.add(:base, 'Line Items present')
			return false
		end
	end
end
