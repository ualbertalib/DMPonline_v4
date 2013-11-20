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
  
  #show details of guidance group
  show do
		attributes_table do
			row	:name
			row :organisation_id do |org_title|
        link_to org_title.organisation.name, [:admin, org_title.organisation]
    	end
    	row :default
    	row :created_at
    	row :updated_at
		end
	end
	
	#guidance list
	sidebar I18n.t("admin.guidance"), :only => :show, :if => proc { guidance_group.guidances.count >= 1}  do
 		 	table_for guidance_group.guidances.order("text asc") do |guis|
 		 		column :text do |gtext|
 		 			link_to gtext.text.html_safe, [:admin, gtext]
 		 		end
 		 		column I18n.t('admin.theme'), :theme_id do |themelist|
   				themelist.theme
	    	end
 		 	end
 		end
	
	#form 	
 	form do |f|
  	f.inputs "Details" do
  		f.input :name
			f.input :organisation_id, :label => I18n.t('admin.org_title'), :as => :select, :collection => Organisation.find(:all, :order => 'name ASC').map{|orgp|[orgp.name, orgp.id]}
			f.input :default
		end
  	f.actions  
  end		
  		
end
