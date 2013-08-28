class Project < ActiveRecord::Base

	extend FriendlyId

	attr_accessible :dmptemplate_id, :locked, :note, :title, :organisation_id, :unit_id

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

	def unit_id=(new_unit_id)
		organisation_id = new_unit_id    
	end
	
	def unit_id
		if organisation.nil? || organisation.parent_id.nil?
			return nil
		else
			return organisation_id
		end
	end
end
