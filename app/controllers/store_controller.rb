class StoreController < ApplicationController
  
  def index
  	@marcas = Product.marcas
  	@productoCop=Product.copeland
    @productoCarr=Product.carrier
    @productoBit=Product.bitzer
    @products = Product.search(false)
  end
end
