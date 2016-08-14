class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true

  def default_url_options
    { locale: I18n.locale }
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
