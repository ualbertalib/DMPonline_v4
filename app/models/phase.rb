class Phase < ActiveRecord::Base

	extend FriendlyId

	#associations between tables
	belongs_to :dmptemplate
	has_many :versions
  
	#Link the child's data
	accepts_nested_attributes_for :versions
	accepts_nested_attributes_for :dmptemplate
 
	attr_accessible :description, :number, :title, :dmptemplate_id, :external_guidance_url
	
	friendly_id :title, use: :slugged, :use => :history
  
	def to_s
		"#{title}"
	end
	
	def latest_version
		return versions.order("number DESC").last
	end
	
	def latest_published_version
		versions.order("number DESC").each do |version|
			if version.published then
				return version
			end
		end
		return nil
	end
	
	# guidance for question in the org admin
	def guidance_for_question(question, org_admin)
	  # pulls together guidance from various sources for question
	  guidances = {}
	  theme_ids = question.theme_ids
	  
	  GuidanceGroup.where("organisation_id = ?", org_admin.id).each do |group|
				group.guidances.each do |g|
						g.themes.where("id IN (?)", theme_ids).each do |gg|
		     			guidances["#{group.organisation.short_name} guidance on #{gg.title}"] = g
		     		end	
		    	end
		 	end
	  	
	  	# Guidance link to directly to a question
			question.guidances.each do |g_by_q|
				g_by_q.guidance_groups.each do |group|
			  	if group.organisation == organisation_admin
			    	guidances["#{group.organisation.short_name} guidance for this question"] = g_by_q
			   	end
				end
	  	end
	  
		
		return guidances
 end	
	
end
