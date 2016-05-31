class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def shibboleth
    if user_signed_in? && current_user.shibboleth_id.present? && current_user.shibboleth_id.length > 0
      flash[:warning] = I18n.t('devise.failure.already_authenticated')
      redirect_to edit_user_registration_path
    else
      auth = request.env['omniauth.auth']
      eppn = auth.info.eppn
      uid = nil
      if !eppn.blank? then
        uid = eppn
      elsif auth.uid.blank? then
        uid = auth.uid
      end

      unless current_user.present?
        s_user = User.from_omniauth(auth).first
        s_user.associate_auth(auth) if s_user && (s_user.shibboleth_id.nil? || s_user.shibboleth_id.blank?)
        s_user ||= User.create_from_omniauth(auth)
      else
        s_user = current_user
        s_user.associate_auth(auth)
      end
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', :kind => 'Shibboleth')
      sign_in s_user, :event => :authentication
      redirect_to edit_user_registration_path
    end
  end
end
