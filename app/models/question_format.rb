class QuestionFormat < ActiveRecord::Base
  translates :title, :description
  attr_accessible :title, :description
  
  #associations between tables
  has_many :questions
  
   def to_s
    "#{title}"
  end
  
  
end
