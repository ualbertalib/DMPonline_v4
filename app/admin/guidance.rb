ActiveAdmin.register Guidance do

	menu :priority => 13, :label => I18n.t('admin.guidance'), :parent => I18n.t('admin.guidance')
	 
	  index do   #:file_id, :text, :guidance_group_id, :theme_id
  		column (:text) { |guidance| raw(guidance.text) }
  		column I18n.t('admin.theme'),  :sortable => :theme_id do |guidance|
   			guidance.theme
	    end
	    column I18n.t('admin.guidance_group') do |guidance| 
	    	(guidance.guidance_groups.map{|t_q| link_to t_q.name, [:admin, t_q]}).join(', ').html_safe
	    end  	
    default_actions
  end
  
  #show details of a question
	show do
		attributes_table do
			row (:text) { |guidance| raw(guidance.text) }
			row I18n.t('admin.theme'), :theme_id do |guidance|
   			guidance.theme
	    end
	    row I18n.t('admin.guidance_group') do |guidance| 
	 		 	(guidance.guidance_groups.map{|t_q| link_to t_q.name, [:admin, t_q]}).join(', ').html_safe
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
  		f.input :guidance_group_ids, :label => I18n.t('admin.guidance_group'), 
  						:as => :select, 
  						:collection => GuidanceGroup.find(:all, :order => 'name ASC').map{|gui|[gui.name, gui.id]}
  		f.input :dmptemplate, :label => I18n.t('admin.template'),
  						:as => :select,
  						:collection => Dmptemplate.find(:all, :order => 'title ASC').map{|temp|[temp.title, temp.id]}		
  		f.input :theme, :as => :select, 
  						:collection => Theme.find(:all, :order => 'title ASC').map{|the| [the.title, the.id]}	
		end
		
		 f.actions  
	end			
	
	
end
