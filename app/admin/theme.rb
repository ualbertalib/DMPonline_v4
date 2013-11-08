ActiveAdmin.register Theme do

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
end
