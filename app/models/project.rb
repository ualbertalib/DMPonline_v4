class Project < ActiveRecord::Base

	extend FriendlyId

	attr_accessible :dmptemplate_id, :locked, :note, :title

	#associations between tables
	belongs_to :dmptemplate
	belongs_to :organisation
	has_many :plans
	has_and_belongs_to_many :guidance_groups
	
	friendly_id :title, use: :slugged
	
	def organisation_name
	 if dmptemplate.nil?
     return false
   else
    return organisation
   end 
	end	

	
end
