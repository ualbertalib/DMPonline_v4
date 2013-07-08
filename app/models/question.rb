class Question < ActiveRecord::Base

  #associations between tables
  has_many :answers
  has_and_belongs_to_many :themes
  belongs_to :section
  accepts_nested_attributes_for :answers
  attr_accessible :default_value, :dependency_id, :dependency_text, :guidance, :number, :parent_id, :suggested_answer, :text, :question_type, :section_id
end
