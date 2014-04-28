class Dmptemplate < ActiveRecord::Base
  attr_accessible :organisation_id, :description, :published, :title, :user_id, :locale, :is_default
  
  #associations between tables
  has_many :phases
  has_many :versions, :through => :phases
  has_many :sections, :through => :versions
  has_many :questions, :through => :sections
  
  belongs_to :organisation
  has_many :projects
  has_many :guidances
  
  
	has_and_belongs_to_many :guidance_groups, join_table: "dmptemplates_guidance_groups"
	
	accepts_nested_attributes_for :guidance_groups
  attr_accessible :guidance_group_ids  
  
  accepts_nested_attributes_for :phases
  accepts_nested_attributes_for :organisation
  accepts_nested_attributes_for :projects
    
  def to_s
    "#{title}"
  end
  
  def self.templates_org_type(ot)
    new_org_obejcts = OrganisationType.find_by_name(ot).organisations
    
    org_templates = Array.new
    new_org_obejcts.each do |neworg|
       org_templates += neworg.dmptemplates.where("published = ?", true)
    end
    
    return org_templates
  end 

	#returns all funders templates
	def self.funders_templates
		new_org_obejcts = OrganisationType.find_by_name(I18n.t("helpers.org_type.funder")).organisations
	  org_templates = Array.new
   	
   	new_org_obejcts.each do |neworg|
       	org_templates += neworg.dmptemplates
    end
    
    return org_templates	
	end
	
	
	#returns all institutional templates bellowing to the current user's org
	def self.own_institutional_templates(org_id)
		new_templates = self.where("organisation_id = ?", org_id)
		return new_templates
	end
	
	#returns an array with all funders and own institutional templates
	def self.funders_and_own_templates(org_id)
		funders_templates = self.funders_templates
	
		own_institutional_templates = self.own_institutional_templates(org_id)
			
		templates_list = Array.new
		templates_list += own_institutional_templates
		templates_list += funders_templates
		templates_list = templates_list.sort_by { |f| f['title'].downcase }
				
		return templates_list
	end
	
	def org_type
		org_type = organisation.organisation_type.name
		return org_type
	end
	
	#verify if a then has customisation by current user's org
	def has_customisations?(org_id, temp)
		if temp.organisation_id != org_id then
			temp.phases.each do |phase|
				phase.versions.each do |version|
					version.sections.each do |section|
						return true if section.organisation_id == org_id 
											
					end	
				end
				return false 
			end
		else
			return false 	
		end	
	end

end
