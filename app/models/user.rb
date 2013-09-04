class User < ActiveRecord::Base
  rolify 
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
    #associations between tables
    belongs_to :user_type
    belongs_to :user_status
    has_many :answers
    has_many :user_org_roles
    has_many :organisations , through: :user_org_roles
    has_many :user_role_types, through: :user_org_roles
  
    attr_accessible :password_confirmation, :encrypted_password, :remember_me, :id, :email, :firstname, :last_login, :login_count, :orcid_id, :password, :shibboleth_id, :user_status_id, :surname, :user_type_id, :organisation_id

	def name
		if firstname.nil? && surname.nil? then
			return email
		else
			return "#{firstname} #{surname}"
		end
	end
	
	def organisation_id=(new_organisation_id)
		new_user_org_role = UserOrgRole.new
		new_user_org_role.organisation_id = new_organisation_id
		new_user_org_role.user_role_type = UserRoleType.find_by_name("user");
		self.user_org_roles << new_user_org_role
	end
	
	def organisation_id
		if self.organisations.count > 0 then
			return self.organisations.first.id
		else
			return nil
		end
	end
	
	def organisation
		if self.organisations.count > 0 then
			return self.organisations.first
		else
			return nil
		end
	end
end
