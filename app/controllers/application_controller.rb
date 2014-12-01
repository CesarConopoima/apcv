class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale
 
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
