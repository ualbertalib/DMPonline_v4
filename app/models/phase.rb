class Phase < ActiveRecord::Base

	extend FriendlyId

	#associations between tables
	belongs_to :dmptemplate
	has_many :versions
  
	#Link the child's data
	accepts_nested_attributes_for :versions
 
	attr_accessible :description, :number, :title, :dmptemplate_id
	
	friendly_id :title, use: :slugged
  
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
end
