ActiveAdmin.register Project do
	#:dmptemplate_id, :locked, :note, :title, :organisation_id, :unit_id, :guidance_group_ids, :project_group_ids, :funder_id, :institution_id, 
	#:grant_number,:identifier, :description, :principal_investigator, :principal_investigator_identifier, :data_contact
	
	 index do  
		column :title
		column I18n.t('admin.org_title'), :sortable => :organisation_id do |org_title|
      link_to org_title, [:admin, org_title.organisation]
  	end
		column I18n.t('admin.template_title'), :sortable => :dmptemplate_id do |dmptemplate|
      link_to dmptemplate.dmptemplate.title, [:admin, dmptemplate.dmptemplate]
    end
	    	
  	
    default_actions
  end
end
