class OrdersController < ApplicationController
  before_filter :ensure_common!, only: [:index,:show,:edit,:update,:destroy]
  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all

    @marcas = Product.marcas
    @productoCop=Product.copeland
    @productoCarr=Product.carrier
    @productoBit=Product.bitzer
    @productoTra=Product.trane
    @productoYork=Product.york
    @products = Product.search(params[:search])
    @cart = current_cart

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])

    @marcas = Product.marcas
    @productoCop=Product.copeland
    @productoCarr=Product.carrier
    @productoBit=Product.bitzer
    @productoTra=Product.trane
    @productoYork=Product.york
    @products = Product.search(params[:search])
    @cart = current_cart

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    @marcas = Product.marcas
    @productoCop=Product.copeland
    @productoCarr=Product.carrier
    @productoBit=Product.bitzer
    @productoTra=Product.trane
    @productoYork=Product.york
    @products = Product.search(params[:search])
    @order = Order.new
  
      @cart = current_cart
      if @cart.line_items.empty?
        redirect_to store_index_path, notice: "Your cart is empty"
        return
      end
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
    @marcas = Product.marcas
    @productoCop=Product.copeland
    @productoCarr=Product.carrier
    @productoBit=Product.bitzer
    @productoTra=Product.trane
    @productoYork=Product.york
    @products = Product.search(params[:search])
    @cart = current_cart
  end

  # POST /orders
  # POST /orders.json
  def create
    @marcas = Product.marcas
    @productoCop=Product.copeland
    @productoCarr=Product.carrier
    @productoBit=Product.bitzer
    @productoTra=Product.trane
    @productoYork=Product.york
    @products = Product.search(params[:search])
    @cart = current_cart

    @order = Order.new(params[:order])
    @order.add_line_items_from_cart(current_cart)
    
    captcha_message = "The data you entered for the CAPTCHA wasn't correct.  Please try again"
    
    if verify_recaptcha

      respond_to do |format|
        if @order.save
          Cart.destroy(session[:cart_id])
          session[:cart_id] = nil
          format.html { redirect_to store_index_path, notice: 'Thank you for your order.' }
          format.json { render json: @order, status: :created, location: @order }
        else
          @cart = current_cart
          format.html { render action: "new" }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end

    else
      flash.now[:alert] = captcha_message
      render :new
    end

  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @marcas = Product.marcas
    @productoCop=Product.copeland
    @productoCarr=Product.carrier
    @productoBit=Product.bitzer
    @productoTra=Product.trane
    @productoYork=Product.york
    @products = Product.search(params[:search])
    @cart = current_cart

    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @marcas = Product.marcas
    @productoCop=Product.copeland
    @productoCarr=Product.carrier
    @productoBit=Product.bitzer
    @productoTra=Product.trane
    @productoYork=Product.york
    @products = Product.search(params[:search])
    @cart = current_cart

    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end
end