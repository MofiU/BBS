class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  rescue_from ActiveRecord::RecordNotFound do
    redirect_to home_error_404_path
  end

  # rescue_from StandardError do |exception|
  #   redirect_to home_error_500_path
  # end

end
