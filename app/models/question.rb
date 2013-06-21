class Question < ActiveRecord::Base

  #associations between tables
  has_many :answer
  has_many :question_theme
  belongs_to :section
  
  attr_accessible :default_value, :dependency_id, :dependency_text, :guidance, :order, :parent_id, :suggested_answer, :text, :type, :section_id
end
