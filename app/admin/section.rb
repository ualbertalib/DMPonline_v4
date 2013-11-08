ActiveAdmin.register Section do

	index do   # :organisation_id, :description, :number, :title, :version_id
  	column :title , :sortable => :title do |section|
        link_to section.title, [:admin, section]
    end
    column I18n.t('admin.template_title'), :sortable => :section_id do |dmptemplate|
        link_to dmptemplate.version.phase.dmptemplate.title, [:admin, dmptemplate.version.phase.dmptemplate]
    end
    column I18n.t('admin.org_title'), :sortable => :organisation_id do |org_title|
        link_to org_title.organisation.name, [:admin, org_title.organisation]
    end
  	
  	default_actions
  end
  
   #show details of a section
  show do 
		attributes_table do
			row :title
	 		row	:number
	 		row :description do |descr|
	  		if !descr.description.nil? then
	  			descr.description.html_safe
	  		end
	  	end
	  	row I18n.t('admin.version_title'), :sortable => :version_id do |version_title|
      	link_to version_title.version.title, [:admin, version_title.version]
     	end
     	row I18n.t('admin.org_title'), :sortable => :organisation_id do |org_title|
        link_to org_title.organisation.name, [:admin, org_title.organisation]
   	 	end
     	row :created_at
     	row :updated_at
		 end
		 
		end 
  
  #questions sidebar(:default_value, :dependency_id, :dependency_text, :guidance, :number, :parent_id, :suggested_answer, :text, :question_type, :section_id)
 		sidebar I18n.t("admin.questions"), :only => :show do
 		 	table_for version.sections.order("number asc") do |temp_phases|
 		 		column :number
 		 		column :text do |row|
      		link_to row.text, [:admin, row]
      	end	
      	
 		 	end
 		end
  
  
end
