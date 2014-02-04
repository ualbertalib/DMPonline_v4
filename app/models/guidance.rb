class Guidance < ActiveRecord::Base
  attr_accessible :file_id, :text, :theme_id, :dmptemplate_id
  
  attr_accessible :guidance_group_ids

	#associations between tables
	belongs_to :theme
	belongs_to :dmptemplate
	has_and_belongs_to_many :guidance_groups, join_table: "guidance_in_group"
	
	def in_group_belonging_to?(organisation_id)
		guidance_groups.each do |guidance_group|
			if guidance_group.organisation_id == organisation_id then
				return true
			end
		end
		return false
	end

end
