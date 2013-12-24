class ApplicationController < ActionController::Base
  protect_from_forgery

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  rescue_from CanCan::AccessDenied do |exception|
    logger.error exception
    render 'home/403'
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    logger.error exception
    render 'home/404'
  end
end
