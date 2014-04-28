class Phase < ActiveRecord::Base

	extend FriendlyId

	#associations between tables
	belongs_to :dmptemplate
	
	has_many :versions, :dependent => :destroy
	has_many :sections, :through => :versions, :dependent => :destroy
  has_many :questions, :through => :sections, :dependent => :destroy
  
	#Link the child's data
	accepts_nested_attributes_for :versions, :allow_destroy => true 
	accepts_nested_attributes_for :dmptemplate
 
	attr_accessible :description, :number, :title, :dmptemplate_id, :external_guidance_url
	
	friendly_id :title, use: :slugged, :use => :history
  
	def to_s
		"#{title}"
	end
	
	def latest_version
		return versions.order("number DESC").last
	end
	
	#Verify if this phase has any published versions
	def latest_published_version
		versions.order("number DESC").each do |version|
			if version.published then
				return version
			end
		end
		return nil
	end
	
	
end
