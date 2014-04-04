class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def shibboleth
    if user_signed_in? && current_user.shibboleth_id.present?
      flash[:warning] = I18n.t('devise.failure.already_authenticated')
      redirect_to root_path
    else
      auth = request.env['omniauth.auth'] || {}
      eppn = auth['extra']['raw_info']['eppn']
      uid = eppn.blank? ? auth['uid'] : eppn        
      
      if !uid.nil? && !uid.blank? then
				s_user = User.where(shibboleth_id: uid).first
				# Take out previous record if was not confirmed.  
				if s_user.confirmed_at.nil?
					sign_out s_user
					User.delete(s_user.id)
					s_user = nil
				end
				
				# Stops Shibboleth ID being blocked if email incorrectly entered.
				if s_user.try(:persisted?)
					flash[:notice] = I18n.t('devise.omniauth_callbacks.success', :kind => 'Shibboleth')
					sign_in_and_redirect s_user, event: :authentication
				else
					if user_signed_in?
						# Reset user password to expire old login details now user using shibboleth
						current_user.update_attribute('shibboleth_id', uid)
						user_id = current_user.id
						sign_out current_user
						session.delete(:shibboleth_data)
						s_user = User.find(user_id)
						sign_in_and_redirect s_user, event: :authentication
					else
						session[:shibboleth_data] = request.env['omniauth.auth']
						session[:shibboleth_data][:uid] = uid
						redirect_to new_user_registration_url(:nosplash => 'true')
					end
				end
      end
    end
  end
  
end