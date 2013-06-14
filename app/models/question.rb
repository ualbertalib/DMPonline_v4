class Question < ActiveRecord::Base

  #associations between tables
  has_many :answer
  has_many :question_theme
  belongs_to :section
  
  attr_accessible :question_default_value, :question_dependency_id, :question_dependency_text, :question_guidance, :question_order, :question_parent_id, :question_suggested_answer, :question_text, :question_type, :section_id
end
