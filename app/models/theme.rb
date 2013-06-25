class Theme < ActiveRecord::Base

  #associations between tables
  has_and_belongs_to_many :questions
  has_many :guidance
  
  attr_accessible :description, :title
end
