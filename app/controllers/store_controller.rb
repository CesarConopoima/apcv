class StoreController < ApplicationController
  def index
  	@marcas = Product.marcas
  	@productoCop=Product.copeland
    @productoCarr=Product.carrier
    @productoBit=Product.bitzer
    @productoTra=Product.trane
    @productoYork=Product.york
    @products = Product.search(params[:search])
    @cart = current_cart
  end
  def home
  	@marcas = Product.marcas
  	@productoCop=Product.copeland
    @productoCarr=Product.carrier
    @productoBit=Product.bitzer
    @productoTra=Product.trane
    @productoYork=Product.york
    @products = Product.search(params[:search])
    @cart = current_cart
  end
  def contact
    @marcas = Product.marcas
    @productoCop=Product.copeland
    @productoCarr=Product.carrier
    @productoBit=Product.bitzer
    @productoTra=Product.trane
    @productoYork=Product.york
    @products = Product.search(params[:search])
    @cart = current_cart
  end
  def products
    @marcas = Product.marcas
    @productoCop=Product.copeland
    @productoCarr=Product.carrier
    @productoBit=Product.bitzer
    @productoTra=Product.trane
    @productoYork=Product.york
    @products = Product.search(params[:search])
    @cart = current_cart
    @marca = params[:marca]
    @name = params[:name].upcase
    @detailProduct = Product.detailproduct(@name,@marca)
  end
  def productslist
    @marcas = Product.marcas
    @productoCop=Product.copeland
    @productoCarr=Product.carrier
    @productoBit=Product.bitzer
    @productoTra=Product.trane
    @productoYork=Product.york
    @products = Product.search(params[:search])
    @cart = current_cart
    @marca = params[:marca]
    @detailProduct = Product.detailproductlist(@marca)
    #@detailProduct = Product.copeland
  end
  def terms
    @marcas = Product.marcas
    @productoCop=Product.copeland
    @productoCarr=Product.carrier
    @productoBit=Product.bitzer
    @productoTra=Product.trane
    @productoYork=Product.york
    @products = Product.search(params[:search])
    @cart = current_cart
  end
end
