class GuidanceGroup < ActiveRecord::Base
  	attr_accessible :organisation_id, :name

	#associations between tables
	belongs_to :organisation
	has_and_belongs_to_many :guidances, join_table: "guidance_in_group"
	has_and_belongs_to_many :projects, join_table: "project_guidance"
	
	def self.guidance_groups_excluding(excluded_orgs)
		excluded_org_ids = Array.new
		excluded_orgs.each do |org|
			excluded_org_ids << org.id
		end
		return GuidanceGroup.where("organisation_id NOT IN (?)", excluded_org_ids)
	end

end
