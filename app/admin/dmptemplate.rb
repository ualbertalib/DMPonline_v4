ActiveAdmin.register Dmptemplate do
	
	 menu :priority => 11, :label => proc{ I18n.t('admin.template')}, :parent => "Templates management"
	
	
  index do   
  	column :title do |dmptemp|
        link_to dmptemp.title, [:admin, dmptemp]
    end
  	column :description do |descr|
  		if !descr.description.nil? then
  			descr.description.html_safe
  		end
  		
  	end
  	column I18n.t('admin.org_title'), :sortable => :organisation_id do |org_title|
        link_to org_title.organisation.name, [:admin, org_title.organisation]
   	end
  	column :published
  	column :is_default
  	
    default_actions
  end
 
 
	# show Template details
	show do 
		attributes_table do
			row :title
	 		row :description do |descr|
	  		if !descr.description.nil? then
	  			descr.description.html_safe
	  		end
	  	end
	  	row I18n.t('admin.org_title'), :sortable => :organisation_id do |org_title|
        link_to org_title.organisation.name, [:admin, org_title.organisation]
   		end
	 		row :published
	 		row :is_default
	 		row :created_at
     	row :updated_at
		 end
		end 
		 
		#phases sidebar
 		sidebar I18n.t("admin.phases"), :only => :show, :if => proc { dmptemplate.phases.count >= 1} do
 		 	table_for dmptemplate.phases.order("number asc") do |temp_phases|
 		 		column :number
 		 		column :title do |row|
      		link_to row.title, [:admin, row]
      	end	
      	
 		 	end
 		end
			 
 	#form 	
 	form do |f|
  	f.inputs "Details" do
  		f.input :title
  		f.input :description
  		f.input :organisation_id, :label => I18n.t('admin.org_title'), 
  						:as => :select, 
  						:collection => Organisation.find(:all, :order => 'name ASC').map{|orgp|[orgp.name, orgp.id]}
  		f.input :published
  		f.input :is_default
  	end
  	f.actions  
  end		
 
end

