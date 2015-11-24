class GuidanceGroup < ActiveRecord::Base
  	
    #associations between tables
    belongs_to :organisation
    
    has_and_belongs_to_many :guidances, join_table: "guidance_in_group"
    
    has_and_belongs_to_many :projects, join_table: "project_guidance"
    has_and_belongs_to_many :dmptemplates, join_table: "dmptemplates_guidance_groups"

    accepts_nested_attributes_for :dmptemplates
    
    attr_accessible :organisation_id, :name, :optional_subset, :published
    attr_accessible :dmptemplate_ids
		
		def to_s
			"#{display_name}"
		end
		
		def display_name
			if organisation.guidance_groups.count > 1
				return "#{organisation.name}: #{name}"
			else
				return organisation.name
			end
		end
		
		def self.guidance_groups_excluding(excluded_orgs)
			excluded_org_ids = Array.new
			excluded_orgs.each do |org|
				excluded_org_ids << org.id
			end
			return_orgs =  GuidanceGroup.where("organisation_id NOT IN (?)", excluded_org_ids)
			return return_orgs
		end
		
		def self.find_by_dmptemplate(template_id)
			guidance_groups = []
			GuidanceGroup.all.each do |gg|
				gg.dmptemplates.each do |t|
					guidance_groups << gg if t.id == template_id
 				end
			end
			return guidance_groups
		end	
		
                def self.find_by_organisation(organisation_id)
			guidance_groups = []
			GuidanceGroup.all.each do |gg|
				guidance_groups << gg if gg.organisation.id == organisation_id
			end
			return guidance_groups
                end
			
	end	
