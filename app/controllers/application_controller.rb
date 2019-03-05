class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[nickname first_name last_name age occupation photo])
    # 1!!
    # !!!For additional in app/views/devise/registrations/edit.html.erb #userme shoul stay or noT???
    devise_parameter_sanitizer.permit(:account_update, keys: %i[nickname first_name last_name age occupation photo])
  end

  def default_url_options
    { host: ENV["HOST"] || "localhost:3000" }
  end
end
