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
	
	def authenticate_admin!
		redirect_to root_path unless user_signed_in? && current_user.is_admin?
	end

	def get_project_list_columns
		# @selected_columns = current_user.preferences.project_columns if user_signed_in?
		# TODO: don't simply store in session - persist instead.
		@selected_columns = session[:project_list_columns] if user_signed_in?
		@selected_columns ||= default_project_list_columns
		@all_columns = default_project_list_columns + %i( identifier grant_number principal_investigator data_contact description )
	end

	def default_project_list_columns
		@default_project_list_columns ||= %i( name owner shared last_edited )
	end

end
