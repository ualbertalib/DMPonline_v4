class User < ActiveRecord::Base
  
  has_one :user_type
  has_one :user_status
  
    attr_accessible :user_email, :user_firstname, :user_last_login, :user_login_count, :user_orcid_id, :user_password, :user_shibboleth_id, :user_status_id, :user_surname, :user_type_id


end
