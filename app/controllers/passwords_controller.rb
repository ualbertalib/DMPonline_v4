class PasswordsController < Devise::PasswordsController
        
	protected
	
	def after_resetting_password_path_for(resource)
      	locale_root_path
        end

end
