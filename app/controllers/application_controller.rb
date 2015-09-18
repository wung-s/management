class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Pundit
  layout 'admin_lte_2'
  
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  	def user_not_authorized
  		flash.now[:error] = "You must be logged in !"
  		redirect_to root_path
  	end


  
end
