class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_locale
  
  # after_filter :store_location

  # def store_location
  # # store last url - this is needed for post-login redirect to whatever the user last visited.
  #   return unless request.get? 
  #   if (request.path != "/users/sign_in" &&
  #     request.path != "/users/sign_up" &&
  #     request.path != "/users/password/new" &&
  #     request.path != "/users/password/edit" &&
  #     request.path != "/users/confirmation" &&
  #     request.path != "/users/sign_out" &&
  #     !request.xhr?) # don't store ajax calls
  #     session[:previous_url] = request.fullpath 
  #   end
  # end

  # def after_sign_in_path_for(resource)
  #   session[:previous_url] || root_path
  # end
  private
  def current_cart
    Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end

  protected
  def authenticate_user!
    redirect_to root_path, notice: "You must login" unless user_signed_in?
  end
  
  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    Rails.application.routes.default_url_options[:locale]= I18n.locale
  end

  def ensure_common!
    unless current_user.common?
      sign_out current_user
      redirect_to root_path
      return false
    end
  end


end
