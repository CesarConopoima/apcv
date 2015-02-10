class OrdersController < ApplicationController
  before_filter :ensure_common!, only: [:index,:show,:edit]
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
  
    @user = current_user
    @order.username = @user.username.to_s + " " +@user.lastname.to_s
    @order.email = @user.email
    @order.telephone1 = @user.telephone
    @order.address = @user.address
    # @order.shipcountry = @user.country

      @cart = current_cart
      
      @flag = false
      @cart.line_items.each do |item|
        if item.quantity < 0
          @flag = true
        end  
      end

      if @cart.line_items.empty? || @flag == true
        redirect_to store_index_path, notice: "Your cart is empty or has products with negative prices"
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
    @order.userid = current_user.id
    #we need to define the order status;
    #perhaps 
    # "Order sent, waiting for your payment information"
    # "Payment information received, cheking your details"
    # "Payment checked, your order has been sent to your ship address"

    @order.status = "Order sent, waiting for your payment information"
    captcha_message = "The data you entered for the CAPTCHA wasn't correct.  Please try again"
    
    # if verify_recaptcha
    # @order.user
      respond_to do |format|
        if @order.save
          OrderNotifier.received(@order,current_user).deliver
          Cart.destroy(session[:cart_id])
          session[:cart_id] = nil
          format.html { redirect_to store_index_path, notice: "Thank you for your order!. 
            You will receive a confirmation email. Please complete your payment information 
            in your account's order section." }
          format.json { render json: @order, status: :created, location: @order }
        else
          @cart = current_cart
          format.html { render action: "new" }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end

    # else
    #   flash.now[:alert] = captcha_message
    #   render :new
    # end

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
        if @order.bankname != nil and @order.refernumber != nil
          #here goes anothe mailer to inform about payment info received
          @order.status = "Payment information received, cheking your details"
          @order.save
          OrderNotifier.paymentinformation(@order,current_user).deliver
          format.html { redirect_to store_orderstatus_path, 
          #this notice should be sent only when users save the correct params for the payment info.
          notice: 'The payment information has been sent, we will process it in the next hours' }
          format.json { head :no_content }
        elsif @order.status.include?("Payment checked")
          format.html { redirect_to order, 
          #this notice should be sent only when users save the correct params for the payment info.
          notice: 'An email has been sent to the client. The client is waiting for his order' }
          format.json { head :no_content }
        else
          format.html { redirect_to store_orderstatus_path, 
          #this notice should be sent only when users save the correct params for the payment info.
          notice: 'Your payment information is not complete!, please enter all field to proccess the payment.' }
          format.json { head :no_content }
        end
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
      format.html { redirect_to :back, notice: 'Your order has been canceled' }
      format.json { head :no_content }
    end
  end
end
