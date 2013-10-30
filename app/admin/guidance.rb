ActiveAdmin.register Guidance do
	 
	  index do   #:file_id, :text, :guidance_group_id, :theme_id
  		column (:text) { |guidance| raw(guidance.text) }
  		column I18n.t('admin.theme'),  :sortable => :theme_id do |guidance|
   			guidance.theme
	    end
	    column I18n.t('admin.guidance_group') do |guidance|
	        (guidance.guidance_groups.map{ |gg| gg.display_name }).join(', ').html_safe
	    end  	
    default_actions
  end
  
  
end
