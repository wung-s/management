class RegistrationsController < Devise::RegistrationsController  
	
	def new
		redirect_to user_session_path
	end

	def create
		redirect_to user_session_path
	end
end