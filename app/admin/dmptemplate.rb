ActiveAdmin.register Dmptemplate do
	
  index do   
  	column :title do |dmptemp|
        link_to dmptemp.title, [:admin, dmptemp]
    end
  	column :description do |descr|
  		if !descr.description.nil? then
  			descr.description.html_safe
  		end
  		
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
	 		row :published
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
			 
 
end

