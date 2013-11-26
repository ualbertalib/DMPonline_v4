ActiveAdmin.register Question do

	menu :priority => 1, :label => proc{I18n.t('admin.question')}, :parent =>  "Templates management"

	index do  #:default_value, :dependency_id, :dependency_text, :guidance, :number, :parent_id, 
		#:suggested_answer, :text, :question_type, :section_id
  	column I18n.t('admin.question'), :text do |descr|
  		if !descr.text.nil? then
  			descr.text.html_safe
  		end
  	end	
  	column I18n.t('admin.section_title'), :sortable => :section_id do |dmptemplate|
        link_to dmptemplate.section.title, [:admin, dmptemplate.section]
    end
    column :number, :sortable => :number do |question_n|
  		 link_to question_n.number, [:admin, question_n]
  	end
  	column I18n.t('admin.template_title'), :sortable => :section_id do |dmptemplate|
        link_to dmptemplate.section.version.phase.dmptemplate.title, [:admin, dmptemplate.section.version.phase.dmptemplate]
    end
  	
   	default_actions
  end
  
  
  #show details of a question
	show do
		attributes_table do
			row	:text do |descr|
	  		if !descr.text.nil? then
	  			descr.text.html_safe
	  		end
	  	end	
	 		row :section_id do |question|
        link_to question.section.title, [:admin, question.section]
    	end
	 		row :number
	 		row :question_type
	 		row :suggested_answer
	 		row :default_value
	 		row :guidance do |qguidance|
	  		if !qguidance.guidance.nil? then
	  			qguidance.guidance.html_safe
	  		end
	  	end	
	  	row :parent_id do |qparent|
	  		if !qparent.parent_id.nil? then
	  			parent_q = Question.where('id = ?', qparent.parent_id)
	  			link_to parent_q.text, [:admin, parent_q]
	  		end
	  	end
	  	row :dependency_id do |qdepend|
	  		if !qdepend.dependency_id.nil? then
	  			qdep = Question.where('id = ?', qparent.dependency_id)
	  			link_to qdep.text, [:admin, qdep]
	  		end
	  	end
	  	row :dependency_text do |dep_text|
	  		if !dep_text.dependency_text.nil? then
	  			dep_text.dependency_text.html_safe
	  		end
	  	end	
	  	row I18n.t('admin.themes') do
	 		 	(question.themes.map{|t_q| link_to t_q.title, [:admin, t_q]}).join(', ').html_safe
	 		end	
	  	row :created_at
	  	row :updated_at
	 		
	 	end	
	end


	#form 
  form do |f|
  	f.inputs "Details" do
  		f.input :text
  		f.input :number
  		f.input :section, 
  						:collection => Section.find(:all, :order => 'title ASC').map{ |sec| [sec.title, sec.id] }
  		f.input :question_type
  		f.input :default_value
  		f.input :suggested_answer
  		f.input :guidance 
  		f.input :parent_id, :label => "Parent", 
  						:as => :select, 
  						:collection => Question.find(:all, :order => 'text ASC').map{|que|[que.text, que.id]}
  		f.input :dependency_id, :label => "Dependency question", 
  						:as => :select, 
  						:collection => Question.find(:all, :order => 'text ASC').map{|que|[que.text, que.id]}
  		f.input :dependency_text
  		f.input :multiple_choice
  		f.input :multiple_permitted
  		f.input :is_expanded  	
  	end
  	f.inputs "Themes" do
  			f.inputs :themes, :label => "Selected themes",
  							:as => :check_boxes, 
  							:multiple => true,
  							:collection => Theme.find(:all, :order => 'title ASC').map{|the| [the.title, the.id]}	
  	end
	 	f.actions  
  end		

end
