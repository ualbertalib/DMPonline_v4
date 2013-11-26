ActiveAdmin.register Role do
	menu :priority => 5, :label => proc{I18n.t('admin.role')}, :parent => "User management"

	index do   
  	column I18n.t('admin.title'), :sortable => :name do |role_name|
        link_to role_name.name, [:admin, role_name]
    end

  	default_actions
  end
  
  show do
		attributes_table do
			row :name
			row :created_at
			row :updated_at
		end
	end		
	
	form do |f|
  	f.inputs "Details" do
      f.input :name
    end    
	  
	  f.actions    
  end
  
end
