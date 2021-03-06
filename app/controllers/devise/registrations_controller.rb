class Devise::RegistrationsController < DeviseController
  prepend_before_filter :require_no_authentication, :only => [:new, :create, :cancel ]
  # prepend_before_filter :authenticate_scope!, :only => [:destroy]

  # GET /resource/sign_up
  def new
  	@marcas = Product.marcas
    @productoCop=Product.copeland
    @productoCarr=Product.carrier
    @productoBit=Product.bitzer
    @productoTra=Product.trane
    @productoYork=Product.york
    @products = Product.search(false)
    @cart = current_cart
    resource = build_resource({})
    respond_with resource

    if current_user
      @user = current_user.id
      @orders = Order.orders(@user) 
    end
  end

  # POST /resource
  def create
  	@marcas = Product.marcas
    @productoCop=Product.copeland
    @productoCarr=Product.carrier
    @productoBit=Product.bitzer
    @productoTra=Product.trane
    @productoYork=Product.york
    @products = Product.search(false)
    @cart = current_cart
    build_resource

    captcha_message = "The data you entered for the CAPTCHA wasn't correct.  Please try again"

    if verify_recaptcha
      
        if resource.save
          if resource.active_for_authentication?
            set_flash_message :notice, :signed_up if is_navigational_format?
            sign_up(resource_name, resource)
            respond_with resource, :location => after_sign_up_path_for(resource)
          else
            set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
            expire_session_data_after_sign_in!
            respond_with resource, :location => after_inactive_sign_up_path_for(resource)
          end
        else
          clean_up_passwords resource
          respond_with resource
        end
    else
      flash.now[:alert] = captcha_message
      render :new
    end

  end

  # GET /resource/edit
  def edit
    @marcas = Product.marcas
    @productoCop=Product.copeland
    @productoCarr=Product.carrier
    @productoBit=Product.bitzer
    @productoTra=Product.trane
    @productoYork=Product.york
    @products = Product.search(false)
    @cart = current_cart

    @user = current_user
    render :edit

 end

  # PUT /resource
  # We need to use a copy of the resource because we don't want to change
  # the current user in place.
  def update
  	@marcas = Product.marcas
    @productoCop=Product.copeland
    @productoCarr=Product.carrier
    @productoBit=Product.bitzer
    @productoTra=Product.trane
    @productoYork=Product.york
    @products = Product.search(false)
    @cart = current_cart

    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    if resource.update_with_password(resource_params) 
      if is_navigational_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, :bypass => true
      respond_with resource, :location => after_update_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  # DELETE /resource
  def destroy
  	@marcas = Product.marcas
    @productoCop=Product.copeland
    @productoCarr=Product.carrier
    @productoBit=Product.bitzer
    @productoTra=Product.trane
    @productoYork=Product.york
    @products = Product.search(false)
    @cart = current_cart
    
    # resource.destroy
    # Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    # set_flash_message :notice, :destroyed if is_navigational_format?
    # respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
    

    @user = current_user
    begin
      #here some logic to avoid elimination of clients with pending orders.
      if Order.orders(@user.id).count == 0
        @user.destroy
        respond_to do |format|
          format.html { redirect_to root_path, notice: 'Your account was eliminate' }
          format.json { head :no_content }
        end
      else
          respond_to do |format|
          format.html { redirect_to :back, alert: "Your account can't be eliminated, you have pendding orders" }
          format.json { head :no_content }
        end
      end
    rescue RuntimeError
      respond_to do |format|
        format.html { redirect_to :back, alert: "You can't eliminate admin" }
        format.json { head :no_content }
      end
    end

    
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    expire_session_data_after_sign_in!
    redirect_to new_registration_path(resource_name)
  end

  protected

  def update_needs_confirmation?(resource, previous)
    resource.respond_to?(:pending_reconfirmation?) &&
      resource.pending_reconfirmation? &&
      previous != resource.unconfirmed_email
  end

  # Build a devise resource passing in the session. Useful to move
  # temporary session data to the newly created user.
  def build_resource(hash=nil)
    hash ||= resource_params || {}
    self.resource = resource_class.new_with_session(hash, session)
  end

  # Signs in a user on sign up. You can overwrite this method in your own
  # RegistrationsController.
  def sign_up(resource_name, resource)
    sign_in(resource_name, resource)
  end

  # The path used after sign up. You need to overwrite this method
  # in your own RegistrationsController.
  def after_sign_up_path_for(resource)
    after_sign_in_path_for(resource)
  end

  # The path used after sign up for inactive accounts. You need to overwrite
  # this method in your own RegistrationsController.
  def after_inactive_sign_up_path_for(resource)
    respond_to?(:root_path) ? root_path : "/"
  end

  # The default url to be used after updating a resource. You need to overwrite
  # this method in your own RegistrationsController.
  def after_update_path_for(resource)
    signed_in_root_path(resource)
  end

  # Authenticates the current scope and gets the current resource from the session.
  def authenticate_scope!
    # send(:"authenticate_#{resource_name}!", :force => true)
    # self.resource = send(:"current_#{resource_name}")
    send(:"authenticate_user!", :force => true)
    self.resource = send(:"current_user")
  end
end