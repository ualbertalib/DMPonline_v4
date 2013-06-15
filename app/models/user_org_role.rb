class UserOrgRole < ActiveRecord::Base

  #associations between tables
  has_one :user
  has one :organisation
  belongs_to :user_role_type
    
  attr_accessible :org_id, :user_id, :user_role_type_id
end
