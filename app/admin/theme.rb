ActiveAdmin.register Theme do

	menu :priority => 12, :label => "Themes"

	index do   # :description, :title, :locale
  	column :title , :sortable => :title do |theme|
        link_to theme.title, [:admin, theme]
    end
		column :description do |descr|
  		if !descr.description.nil? then
  			descr.description.html_safe
  		end
  	end
  	
  	default_actions
  end
  
  #show details of a theme
  show do
  	attributes_table do
			row :title
			row :description
			row :created_at
			row :updated_at
		end	
  end
  
  #form
  form do |f|
  	f.inputs "Details" do
  		f.input :title
  		f.input :description
		end
		 f.actions  
	end			
	
	
end
