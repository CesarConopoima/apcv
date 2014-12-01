class StoreController < ApplicationController
  
  def index
  	@Productos = Product.marcas
  end
end
