ActiveAdmin.register Organisation do

	index do   # :abbreviation, :banner_file_id, :description, :domain, :logo_file_id, :name, 
		#:stylesheet_file_id, :target_url, :organisation_type_id, :wayfless_entity, :parent_id
  	column I18n.t('admin.name'), :sortable => :name do |ggn|
        link_to ggn.name, [:admin, ggn]
    end
    column I18n.t('admin.abbrev'), :sortable => :abbreviation do |ggn|
        if !ggn.abbreviation.nil?
        	link_to ggn.abbreviation, [:admin, ggn]
        else
        	'-'
        end
        
    end
    column I18n.t('admin.org_title'), :sortable => :organisation_type_id do |org_type|
        link_to org_type.organisation_type.name, [:admin, org_type]
    end
  	
  	default_actions
  end
end
