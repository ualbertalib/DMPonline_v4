ActiveAdmin.register User do
	
	index do   # :password_confirmation, :encrypted_password, :remember_me, :id, :email, :firstname, :last_login, :login_count, :orcid_id, 
		#:password, :shibboleth_id, :user_status_id, :surname, :user_type_id, :organisation_id, :skip_invitation
  	column I18n.t('admin.user_name'), :sortable => :email do |user_email|
        link_to user_email.email, [:admin, user_email]
    end
    column I18n.t('admin.firstname'), :sortable => :firstname do |use_first|
        link_to use_first.firstname, [:admin, use_first]
    end
  	column I18n.t('admin.surname'), :sortable => :surname do |user|
        link_to user.surname, [:admin, user]
    end
   	column I18n.t('admin.user_status'), :sortable => :user_status_id do |status|
   		if !status.user_status.nil? then
        status.user_status.name	 
			else
        	'-'
      end
   	end
   	
   	column I18n.t('admin.user_status'), :sortable => :last_login
   	
  	
  	default_actions
  end
end
