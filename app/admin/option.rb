ActiveAdmin.register Option do
	menu :priority => 1, :label => proc{I18n.t('admin.multi_options')}, :parent =>  "Templates management"

	index do   # :question_id, :text, :number, :is_default 
  	column :text
  	column I18n.t('admin.questions'), :sortable => :question_id do |ques|
        link_to ques.question.text, [:admin, ques.question]
    end
    column I18n.t('admin.sections'), :sortable => :question_id do |ques|
        link_to ques.question.section.title, [:admin, ques.question.section]
    end
   
  	
  	default_actions
  end
  
  
end
