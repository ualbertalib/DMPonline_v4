ActiveAdmin.register User do
	
	 menu :priority => 15, :label => proc{ I18n.t('admin.user')}, :parent => "User management"
	
	index do   # :password_confirmation, :encrypted_password, :remember_me, :id, :email, :firstname, :orcid_id, 
		# :shibboleth_id, :user_status_id, :surname, :user_type_id, :organisation_id, :skip_invitation
  	column I18n.t('admin.user_name'), :sortable => :email do |user_email|
        link_to user_email.email, [:admin, user_email]
    end
    column I18n.t('admin.firstname'), :sortable => :firstname do |use_first|
        link_to use_first.firstname, [:admin, use_first]
    end
  	column I18n.t('admin.surname'), :sortable => :surname do |user|
        link_to user.surname, [:admin, user]
    end
   	column I18n.t('admin.last_logged_in'), :last_sign_in_at 
   	column I18n.t('admin.org_title'), :organisation_id do |org_title|
      if !org_title.organisation.nil? then
        	 link_to org_title.organisation.name, [:admin, org_title.organisation]
       end
   	end
      	
  	default_actions
  end
  
  show do
  		attributes_table do
  			row :firstname
  			row :surname
  			row :email
  			row :orcid_id
  			row I18n.t('admin.org_title'), :organisation_id do |org_title|
		      if !org_title.organisation.nil? then
		        	 link_to org_title.organisation.name, [:admin, org_title.organisation]
		      end
		   	end
		   	row :other_organisation
  			row I18n.t('admin.user_status'), :user_status_id do |us|
  				if !us.user_status.nil? then
  					link_to us.user_status.name, [:admin, us.user_status]
  				end		
  			end
  			row I18n.t('admin.user_type'), :user_type_id do |ut|
  				if !ut.user_type.nil? then
  					link_to ut.user_type.name, [:admin, ut.user_type]
  				else
  					'-'
  				end		
  			end
  			row I18n.t('admin.user_role') do 
  				(user.roles.map{|ro| link_to ro.name, [:admin, ro]}).join(', ').html_safe
  			end
  			row :shibboleth_id
  			row :last_sign_in_at
  			row :sign_in_count 

  		end
  end
  
  
  form do |f|
  	f.inputs "Details" do
        f.input :firstname
  			f.input :surname
  			f.input :email
  			f.input :orcid_id
  			f.input :organisation_id,:label => I18n.t('admin.org_title'), 
  						:as => :select, 
  						:collection => Organisation.find(:all, :order => 'name ASC').map{|orgp|[orgp.name, orgp.id]}
  			f.input :user_status_id, :label => I18n.t('admin.user_status'), 
  						:as => :select, 
  						:collection => UserStatus.find(:all, :order => 'name ASC').map{|us|[us.name, us.id]}
  			f.input :user_type_id, :label => I18n.t('admin.user_type'), 
  						:as => :select, 
  						:collection => UserType.find(:all, :order => 'name ASC').map{|ut|[ut.name, ut.id]}  		
  			f.inputs :roles, :label => "User role",
  							:as => :select, 
  							:collection => Role.find(:all, :order => 'name ASC').map{|ro| [ro.name, ro.id]},	
  							:selected => @roles				
    end
    
    f.actions    
  end
  
end
