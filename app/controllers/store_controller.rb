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
    if current_user
      @user = current_user.id
      @orders = Order.orders(@user) 
    end
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

    if current_user
      @user = current_user.id
      @orders = Order.orders(@user) 
    end

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
    if current_user
      @user = current_user.id
      @orders = Order.orders(@user) 
    end
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
    if current_user
      @user = current_user.id
      @orders = Order.orders(@user) 
    end
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
    if current_user
      @user = current_user.id
      @orders = Order.orders(@user) 
    end
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
    if current_user
      @user = current_user.id
      @orders = Order.orders(@user) 
    end
  end
  def orderstatus
    @marcas = Product.marcas
    @productoCop=Product.copeland
    @productoCarr=Product.carrier
    @productoBit=Product.bitzer
    @productoTra=Product.trane
    @productoYork=Product.york
    @products = Product.search(params[:search])
    @cart = current_cart
    @user = current_user.id
    
    if current_user
      @user = current_user.id
      @orders = Order.orders(@user) 
    end
  end

  def payinfo
    @order = Order.find(params[:id])
    @billing = params[:bill]
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
