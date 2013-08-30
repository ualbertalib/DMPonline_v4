class Project < ActiveRecord::Base

	extend FriendlyId

	attr_accessible :dmptemplate_id, :locked, :note, :title, :organisation_id, :unit_id, :guidance_group_ids

	#associations between tables
	belongs_to :dmptemplate
	belongs_to :organisation
	has_many :plans
	has_and_belongs_to_many :guidance_groups, join_table: "project_guidance"
	
	friendly_id :title, use: :slugged
	
	after_create :create_plans
	
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
	
	def create_plans
		dmptemplate.phases.each do |phase|
			latest_published_version = phase.latest_published_version
			unless latest_published_version.nil?
				new_plan = Plan.new
				new_plan.version = latest_published_version
				plans << new_plan
			end
		end
	end
end
