class QuestionTheme < ActiveRecord::Base
  
  #associations between tables
  has_one :question
  has_one :theme
  
  attr_accessible :question_id, :theme_id
end
