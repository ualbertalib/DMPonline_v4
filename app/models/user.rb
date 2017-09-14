class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable, :omniauth_providers => [:shibboleth]

    #associations between tables
    belongs_to :user_type
    belongs_to :user_status
    has_many :answers
    has_many :user_org_roles
    has_many :project_groups, :dependent => :destroy
    has_many :organisations , through: :user_org_roles
    has_many :user_role_types, through: :user_org_roles

    has_many :projects, through: :project_groups do
      def filter(query)
        return self unless query.present?

        t = self.arel_table
        q = "%#{query}%"

        conditions = t[:title].matches(q)

        columns = %i(
          grant_number identifier description principal_investigator data_contact
        )

        columns.each {|col| conditions = conditions.or(t[col].matches(q)) }

        self.where(conditions)
      end
    end

    has_and_belongs_to_many :roles, :join_table => :users_roles
    has_many :plan_sections

    accepts_nested_attributes_for :roles
    attr_accessible :role_ids

    attr_accessible :password_confirmation, :encrypted_password, :remember_me, :id, :email, :firstname, :last_login,
     :login_count, :orcid_id, :password, :shibboleth_id, :user_status_id,
     :surname, :user_type_id, :organisation_id, :skip_invitation, :other_organisation,
     :accept_terms, :role_ids, :dmponline3, :provider

    # FIXME: The duplication in the block is to set defaults. It might be better if
    #        they could be set in Settings::PlanList itself, if possible.
    has_settings :plan_list, class_name: 'Settings::PlanList' do |s|
      s.key :plan_list, defaults: { columns: Settings::PlanList::DEFAULT_COLUMNS }
    end

    def self.from_omniauth(auth)
      users = User.where('(email = ? OR email = ? OR shibboleth_id = ? OR shibboleth_id = ? OR shibboleth_id =? )',auth.info.email, auth.info.eppn, auth.uid, auth.info.eppn, auth.info.email)
      return users
    end


    def self.create_from_omniauth(auth)
      raise(ArgumentError, 'UID is blank in Shibboleth authorization') unless auth.uid.present? || auth.info.eppn.present?
      email = auth.info.email || auth.info.eppn 
      uid = auth.uid || auth.info.eppn
      create(
        email: email,
        password:Devise.friendly_token[0,20],
        ccid: uid,
        confirmed_at: Time.now.utc
      )
    end

    def associate_auth(auth)
      self.shibboleth_id = auth.uid || auth.info.eppn
      save!
    end

	def name(use_email = true)
		if ((firstname.nil? && surname.nil?) || (firstname.strip == "" && surname.strip == "")) && use_email then
			return email
		else
			name = "#{firstname} #{surname}"
			return name.strip
		end
	end

	def organisation_id=(new_organisation_id)
    if !self.user_org_roles.pluck(:organisation_id).include?(new_organisation_id.to_i) then
  		if self.user_org_roles.count != 1 then
  			new_user_org_role = UserOrgRole.new
  			new_user_org_role.organisation_id = new_organisation_id
  			new_user_org_role.user_role_type = UserRoleType.find_by_name("user");
  			self.user_org_roles << new_user_org_role
  		else
  			user_org_role = self.user_org_roles.first
  			user_org_role.organisation_id = new_organisation_id
            user_org_role.save
  			org_admin_role = roles.find_by_name("org_admin")
  			unless org_admin_role.nil? then
  				roles.delete(org_admin_role)
  			end
  		end
    end
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

	def current_organisation
		if self.organisations.count > 0 then
			return self.organisations.last
		else
			return nil
		end
	end

	def organisation=(new_organisation)
		organisation_id = organisation.id
	end

	def is_admin?
		admin = roles.find_by_name("admin")
		return !admin.nil?
	end

	def is_org_admin?
		org_admin = roles.find_by_name("org_admin")
		return !org_admin.nil?
	end
    
        def org_type
          org_type = organisation.organisation_type.name
	  return org_type
        end
        # For masking the ID that we send to rollbar
        def id_as_hash
          Digest::SHA2.hexdigest("#{DMPonline4::Application.config.secret_token}_#{id}")
        end


end
