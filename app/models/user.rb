class User < ActiveRecord::Base
  rolify 
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
    #associations between tables
    has_one :user_type
    has_one :user_status
    has_many :answers
  
    attr_accessible :password_confirmation, :encrypted_password, :remember_me, :id, :email, :firstname, :last_login, :login_count, :orcid_id, :password, :shibboleth_id, :user_status_id, :surname, :user_type_id

	def name
		return "#{firstname} #{surname}"
	end

end
