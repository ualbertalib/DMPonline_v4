class Organisation < ActiveRecord::Base
  
	#associations between tables
	has_many :dmptemplates
	belongs_to :organisation_type
	has_many :guidance_groups
	belongs_to :parent, :class_name => 'Organisation'
	has_many :children, :class_name => 'Organisation', :foreign_key => 'parent_id'
	 
	accepts_nested_attributes_for :organisation_type
	accepts_nested_attributes_for :dmptemplates
	
	attr_accessible :abbreviation, :banner_file_id, :description, :domain, :logo_file_id, :name, :stylesheet_file_id, :target_url, :organisation_type_id, :wayfless_entity, :parent_id
	
	
	#retrieves info off a child org 
	def self.orgs_with_parent_of_type(org_type)
		parents = OrganisationType.find_by_name(org_type).organisations
		children = Array.new
		parents.each do |parent| 
		  	children += parent.children
		end
		return children
	end
	 
	  
	def self.other_organisations
		org_types = [I18n.t('helpers.org_type.organisation')]
		  	organisations_list = []
		  	org_types.each do |ot|
		    	new_org_obejct = OrganisationType.find_by_name(ot)
		    	
		    	org_with_guidance = GuidanceGroup.joins(new_org_obejct.organisations)
		    	
		    	organisations_list = organisations_list + org_with_guidance
			end
		  	return organisations_list
		end
	  
	end
