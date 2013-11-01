ActiveAdmin.register Theme do

	index do   # :description, :title, :locale
  	column :title , :sortable => :title do |theme|
        link_to theme.title, [:admin, theme]
    end
		column :description
  	
  	default_actions
  end
end
