class UserRoleType < ActiveRecord::Base
  
  has_many :user_org_roles
  
  attr_accessible :description, :name
end
