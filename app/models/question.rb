class Question < ActiveRecord::Base

  #associations between tables
  has_many :answer
  has_and_belongs_to_many :themes
  belongs_to :section
  
  attr_accessible :default_value, :dependency_id, :dependency_text, :guidance, :order, :parent_id, :suggested_answer, :text, :type, :section_id
end
