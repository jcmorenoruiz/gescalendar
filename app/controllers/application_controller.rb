class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception
  include SessionsHelper
  include RequestsHelper

# 	rescue_from ActiveRecord::RecordNotFound, :with => :not_found

 # def not_found
 #   raise ActionController::RoutingError.new('Not Found')
 # end

  def bts
    return 'Inactivo' unless self
    return 'Activo' if self.class == TrueClass
  end
end
