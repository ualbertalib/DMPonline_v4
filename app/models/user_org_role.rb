class UserOrgRole < ActiveRecord::Base
  attr_accessible :organisation_id, :user_id, :user_role_type_id
end
