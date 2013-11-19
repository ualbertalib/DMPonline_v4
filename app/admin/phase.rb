ActiveAdmin.register Phase do	
	
	# :description, :number, :title, :dmptemplate_id, :external_guidance_url
	index do   
  	column :title do |ph|
        link_to ph.title, [:admin, ph]
    end
  	column :description do |des_ph|
  		if !des_ph.description.nil? then
  			des_ph.description.html_safe
  		end
  	end
  	column :number
  	column I18n.t('admin.template_title'), :sortable => :dmptemplate_id do |temp_title|
      link_to temp_title.dmptemplate.title, [:admin, temp_title.dmptemplate]
     end
  	
    default_actions
  end
  
  #show details of a phase
  show do 
		attributes_table do
			row :title
	 		row	:number
	 		row :description do |descr|
	  		if !descr.description.nil? then
	  			descr.description.html_safe
	  		end
	  	end	
	  	row I18n.t('admin.template_title'), :sortable => :dmptemplate_id do |temp_title|
      	link_to temp_title.dmptemplate.title, [:admin, temp_title.dmptemplate]
     	end
     	row :external_guidance_url
     	row :created_at
     	row :updated_at
		 end
		 
		end 
  
  #versions sidebar
 		sidebar I18n.t("admin.version"), :only => :show, :if => proc { phase.versions.count >= 1}  do
 		 	table_for phase.versions.order("number asc") do |temp_phases|
 		 		column :number
 		 		column :title do |row|
      		link_to row.title, [:admin, row]
      	end	
      	column :published, :sortable => :published do |v_published|
					if (v_published.published == 1)
						'Yes'
					else
						'No'	
					end
				end
      	
 		 	end
 		end
  
      
end
