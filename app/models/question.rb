class Question < ActiveRecord::Base

  #associations between tables
  has_many :answers
  has_many :options
  has_many :suggested_answers
  has_and_belongs_to_many :themes
  belongs_to :section
  accepts_nested_attributes_for :answers
  attr_accessible :default_value, :dependency_id, :dependency_text, :guidance, :number, :parent_id, :suggested_answer, :text, :question_type, :section_id

	def get_suggested_answer(organisation_id)
		answer = suggested_answers.find_by_organisation_id(organisation_id)
		if answer.nil? then
			suggested_answer
		else
			answer.text
		end
	end
end
