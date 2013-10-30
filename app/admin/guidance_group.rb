ActiveAdmin.register GuidanceGroup do
	
	index do   #:organisation_id, :name
  	column I18n.t('admin.name'), :sortable => :name do |ggn|
        link_to ggn.name, [:admin, ggn]
    end
    column I18n.t('admin.org_title'), :sortable => :organisation_id do |org_title|
        link_to org_title.organisation.name, [:admin, org_title.organisation]
    end
  	
  	default_actions
  end
end
