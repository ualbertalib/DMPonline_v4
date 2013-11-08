ActiveAdmin.register Question do

	index do  #:default_value, :dependency_id, :dependency_text, :guidance, :number, :parent_id, 
		#:suggested_answer, :text, :question_type, :section_id
  	column :number, :sortable => :number do |question_n|
  		 link_to question_n.number, [:admin, question_n]
  	end
  	column I18n.t('admin.section_title'), :sortable => :section_id do |dmptemplate|
        link_to dmptemplate.section.title, [:admin, dmptemplate.section]
    end
  	column I18n.t('admin.template_title'), :sortable => :section_id do |dmptemplate|
        link_to dmptemplate.section.version.phase.dmptemplate.title, [:admin, dmptemplate.section.version.phase.dmptemplate]
    end
  	column I18n.t('admin.question'), :text do |descr|
  		if !descr.text.nil? then
  			descr.text.html_safe
  		end
  	end	
   
  	
  	default_actions
  end
end
