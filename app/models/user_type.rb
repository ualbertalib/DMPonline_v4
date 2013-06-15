class UserType < ActiveRecord::Base

  #associations between tables
  has_many :user
  
  attr_accessible :user_type_desc, :user_type_name
end
