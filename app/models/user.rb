class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
    #associations between tables
    has_one :user_type
    has_one :user_status
  
    attr_accessible :email, :firstname, :last_login, :login_count, :orcid_id, :password, :shibboleth_id, :user_status_id, :surname, :user_type_id


end
