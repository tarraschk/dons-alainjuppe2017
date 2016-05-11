class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from ActionController::InvalidAuthenticityToken do |exception|
    render(:json => {error: "Bad CSRF Token", session: form_authenticity_token, token: params[:authenticity_token], check: verify_authenticity_token}, :status => :forbidden)
  end
end
