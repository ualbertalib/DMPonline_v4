class ConfirmationsController < Devise::ConfirmationsController

  protected

  def after_confirmation_path_for(resource_name, resource)
  	logger.debug "redirecting... I hope"
    root_path
  end

end