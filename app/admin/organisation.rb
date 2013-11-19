ActiveAdmin.register Organisation do

	index do   # :abbreviation, :banner_file_id, :description, :domain, :logo_file_id, :name, 
		#:stylesheet_file_id, :target_url, :organisation_type_id, :wayfless_entity, :parent_id
  	column I18n.t('admin.org_title'), :sortable => :name do |ggn|
        link_to ggn.name, [:admin, ggn]
    end
    column I18n.t('admin.abbrev'), :sortable => :abbreviation do |ggn|
        if !ggn.abbreviation.nil?
        	link_to ggn.abbreviation, [:admin, ggn]
        else
        	'-'
        end
    end
    column I18n.t('admin.org_type'), :sortable => :organisation_type_id do |org_type|
        link_to org_type.organisation_type.name, [:admin, org_type]
    end
  	
  	default_actions
  end
  
  
  #show details of an organisation
  show do 
		attributes_table do
			row I18n.t('admin.org_title'), :sortable => :name do |ggn|
        link_to ggn.name, [:admin, ggn]
    	end
			row I18n.t('admin.abbrev'), :abbreviation do |ggn|
        if !ggn.abbreviation.nil?
        	link_to ggn.abbreviation, [:admin, ggn]
        else
        	'-'
        end
			end
			row I18n.t('admin.org_type'), :organisation_type_id do |org_type|
        link_to org_type.organisation_type.name, [:admin, org_type]
      end  
      row :description do |descr|
	  		if !descr.description.nil? then
	  			descr.description.html_safe
	  		end
      end
     	row :target_url
      row :domain
      row :wayfless_entity
      row I18n.t('admin.org_parent'), :parent_id do |org_parent|
      	if !org_parent.parent_id.nil? then
      		link_to org_parent.organisation.name, [:admin, org_parent]
      	end	
      end
    	row :logo_file_id
     	row :banner_file_id
    	row :stylesheet_file_id
    	row :created_at
    	row :updated_at
		end
	end		
	
	#templates sidebar
 	sidebar I18n.t("admin.templates"), :only => :show, :if => proc { organisation.dmptemplates.count >= 1} do
	 	table_for organisation.dmptemplates.order("title asc") do |temp|
	 		column :title do |dmptemp|
     		link_to dmptemp.title, [:admin, dmptemp]
  		end
    	column :published
	 	end
	end

	
  
end
