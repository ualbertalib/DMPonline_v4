ActiveAdmin.register Version do

	index do   # :description, :number, :published, :title, :phase_id
  	column I18n.t('admin.title'), :sortable => :title  do |version_used|
        link_to version_used.title, [:admin, version_used]
    end
    column I18n.t('admin.desc'),:description do |descr|
  		if !descr.description.nil? then
  			descr.description.html_safe
  		end
  	end	
    column I18n.t('admin.version_numb'), :number
		column :published, :sortable => :published do |v_published|
			if (v_published.published == 1)
				'Yes'
			else
				'No'	
			end
		end
		column I18n.t('admin.phase_title'), :sortable => :phase_id do |version_phase|
        link_to version_phase.phase.title, [:admin, version_phase.phase]
    end
    	
  	default_actions
  end
  
  #show details of a version
  show do 
		attributes_table do
			row :title
	 		row	:number
	 		row :description do |descr|
	  		if !descr.description.nil? then
	  			descr.description.html_safe
	  		end
	  	end
	  	row I18n.t('admin.phase_title'), :sortable => :phase_id do |phase_title|
      	link_to phase_title.phase.title, [:admin, phase_title.phase]
     	end
     	row :published
     	row :created_at
     	row :updated_at
		 end
		 
		end 
  
  #sections sidebar  (:organisation_id, :description, :number, :title, :version_id)
 		sidebar I18n.t("admin.sections"), :only => :show, :if => proc { version.sections.count >= 1}  do
 		 	table_for version.sections.order("number asc") do |temp_phases|
 		 		column :number
 		 		column :title do |row|
      		link_to row.title, [:admin, row]
      	end	
      	column I18n.t('admin.org_title'), :sortable => :organisation_id do |org_title|
       		link_to org_title.organisation.name, [:admin, org_title.organisation]
    		end
      	
 		 	end
 		end
  

end
