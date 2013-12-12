class Question < ActiveRecord::Base

  #associations between tables
  has_many :answers
  has_many :options
  has_many :suggested_answers
  has_and_belongs_to_many :themes
  belongs_to :section
  accepts_nested_attributes_for :answers
  accepts_nested_attributes_for :themes
  attr_accessible :theme_ids
  
  attr_accessible :default_value, :dependency_id, :dependency_text, :guidance, :number, :parent_id, :suggested_answer, :text, :question_type, :section_id, :multiple_choice, :multiple_permitted, :is_expanded

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
end
