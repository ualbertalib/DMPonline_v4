class ApplicationController < ActionController::Base
 protect_from_forgery
  
 # Override build_footer method in ActiveAdmin::Views::Pages
  require 'active_admin_views_pages_base.rb'
  
 rescue_from CanCan::AccessDenied do |exception|
     redirect_to root_url, :alert => exception.message
 end
 
 	after_filter :store_location

	def store_location
	 # store last url - this is needed for post-login redirect to whatever the user last visited.
		if (request.fullpath != "/users/sign_in" && \
			request.fullpath != "/users/sign_up" && \
			request.fullpath != "/users/password" && \
			!request.xhr?) # don't store ajax calls
		  session[:previous_url] = request.fullpath 
		end
	end

	def after_sign_in_path_for(resource)
	  session[:previous_url] || root_path
	end

	def after_sign_up_path_for(resource)
	  session[:previous_url] || root_path
	end
	
	def after_sign_in_error_path_for(resource)
	  session[:previous_url] || root_path
	end
	
	def after_sign_up_error_path_for(resource)
	  session[:previous_url] || root_path
	end

end
