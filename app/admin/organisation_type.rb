ActiveAdmin.register OrganisationType do

	index do   #:organisation_id, :name
  	column I18n.t('admin.title'), :sortable => :name do |ggn|
        link_to ggn.name, [:admin, ggn]
    end
    column I18n.t('admin.desc'),:description 
  	
  	default_actions
  end
end
