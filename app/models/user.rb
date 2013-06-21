class User < ActiveRecord::Base
  
    #associations between tables
    has_one :user_type
    has_one :user_status
  
    attr_accessible :email, :firstname, :last_login, :login_count, :orcid_id, :password, :shibboleth_id, :user_status_id, :surname, :user_type_id


end
