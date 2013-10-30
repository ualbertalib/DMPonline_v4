ActiveAdmin.register Guidance do
	 
	  index do   #:file_id, :text, :guidance_group_id, :theme_id
  		column :text
  		column I18n.t('admin.theme'), :theme_id do |theme|
        link_to theme, [:admin, theme]
	    end
	    column I18n.t('admin.guidance_group'), :guidance_group_id do |guidance_group|
	        if !gg.nil? then
	        	link_to guidance_group.name, [:admin, guidance_group]
	        else
	        	I18n.t('admin.no_guidance_group')
	        end	
	    end
	  	
  	
    default_actions
  end
  
  
end
