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
  
  #show details of a question
	show do
		attributes_table do
			row (:text) { |guidance| raw(guidance.text) }
			row :theme_id do |guidance|
   			guidance.theme
	    end
	    row :guidance_group_id do |guidance|
	        (guidance.guidance_groups.map{ |gg| gg.display_name }).join(', ').html_safe
	    end
	    row I18n.t('admin.template'), :dmptemplate do |temp|
	    	if !temp.dmptemplate.nil? then
	    		link_to temp.dmptemplate.title, [:admin, temp.dmptemplate]
	    	end
	    end  	
	    row :created_at
	    row :updated_at
		end
	end

	#form 
  form do |f|
  	f.inputs "Details" do
  		f.input :text
  		f.input :guidance_group_id, :label => I18n.t('admin.guidance_group'), :as => :select, :collection => GuidanceGroup.all.map{|gui|[gui.name, gui.id]}
  		f.input :theme, :as => :check_boxes, :collection => Theme.all.map{|the| [the.title, the.id]}	
		end
		 f.actions  
	end			
end
