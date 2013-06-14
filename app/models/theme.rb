class Theme < ActiveRecord::Base

  #associations between tables
  has_many :question_theme
  has_many :guidance
  
  attr_accessible :theme_desc, :theme_title
end
