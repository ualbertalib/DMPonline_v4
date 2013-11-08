ActiveAdmin.register OrganisationType do

	index do   #:organisation_id, :name
  	column I18n.t('admin.title'), :sortable => :name do |ggn|
        link_to ggn.name, [:admin, ggn]
    end
    column I18n.t('admin.desc'), :description do |descr|
  		if !descr.description.nil? then
  			descr.description.html_safe
  		end
  	end
  	
  	default_actions
  end
end
