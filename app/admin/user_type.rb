ActiveAdmin.register UserType do

	index do   # :description, :name
  	column I18n.t('admin.title'), :sortable => :name do |user_n|
        link_to user_n.name, [:admin, user_n]
    end
     column I18n.t('admin.desc'),:description 
  	
  	default_actions
  end
  
end
