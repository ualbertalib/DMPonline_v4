class Question < ActiveRecord::Base

  #associations between tables
  has_many :answers
  has_many :options, :dependent => :destroy
  has_many :suggested_answers, :dependent => :destroy
  has_many :guidances
  has_and_belongs_to_many :themes
  belongs_to :section
  belongs_to :question_format
  accepts_nested_attributes_for :answers
  accepts_nested_attributes_for :options, :reject_if => lambda {|a| a[:text].blank? },  :allow_destroy => true 
  accepts_nested_attributes_for :suggested_answers, :reject_if => lambda {|a| a[:text].blank? },  :allow_destroy => true 
  accepts_nested_attributes_for :themes
  attr_accessible :theme_ids
  
  attr_accessible :default_value, :dependency_id, 
  								:dependency_text, :guidance, 
  								:number, :parent_id, :suggested_answer, 
  								:text, 
  								:question_type, :section_id, 
  								:multiple_choice, 
  								:multiple_permitted, 
  								:is_expanded, 
  								:is_text_field,
  								:question_format_id

	def to_s
    "#{text}"
  end

	#Collect suggested answers
	def get_suggested_answer(organisation_id)
		answer = suggested_answers.find_by_organisation_id(organisation_id)
		return_value = {}
		if answer.nil? then
			return_value["heading"] = I18n.t('helpers.suggested_answer')
			return_value["content"] = suggested_answer
		elsif answer.is_example then
			return_value["heading"] = I18n.t('helpers.suggested_example')
			return_value["content"] = answer.text
		else
			return_value["heading"] = I18n.t('helpers.suggested_answer')
			return_value["content"] = answer.text
		end
		return return_value
	end
	
	def question_type?
		type_label = {}
		if self.is_text_field? 
		  type_label = 'Text field'
		elsif self.multiple_choice?
			type_label = 'Multiple choice'
		else
			type_label = 'Text area'
		end
		return type_label
	end 
	
	def question_themes?
		themes_label = {}
		i = 0
		themes_quest = themes.where("id IN (?)", self.theme_ids)
		
		themes_quest.each do |tt|
			themes_label = tt.title
			
			unless themes_quest.length <= 1 || i <= themes_quest.length 
				themes_label +=	','		
				i +=1		
			end
		end
		
		return themes_label
	end
		
	

		
end
