class UserStatus < ActiveRecord::Base

  #associations between tables
  has_many :user
  
  attr_accessible :user_status_desc, :user_status_name
end
