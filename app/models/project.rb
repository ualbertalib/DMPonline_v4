class Project < ActiveRecord::Base

	extend FriendlyId

	attr_accessible :dmptemplate_id, :locked, :note, :title, :organisation_id, :unit_id, :guidance_group_ids, :project_group_ids

	#associations between tables
	belongs_to :dmptemplate
	belongs_to :organisation
	has_many :plans
	has_many :project_groups
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
	
	def assign_creator(user_id)
		add_user(user_id, true, true)
	end
	
	def assign_editor(user_id)
		add_user(user_id, true)
	end
	
	def assign_reader(user_id)
		add_user(user_id)
	end
	
	def can_edit(user_id)
		user = project_groups.find_by_user_id(user_id)
		if (! user.nil?) && user.project_editor then
			return true
		else
			return false
		end
	end
	
	def can_read(user_id)
		user = project_groups.find_by_user_id(user_id)
		if (! user.nil?) then
			return true
		else
			return false
		end
	end
	
	def self.projects_for_user(user_id)
		projects = Array.new
		groups = ProjectGroup.where("user_id = ?", user_id)
		unless groups.nil? then
			groups.each do |group|
				projects << group.project
			end
		end
		return projects
	end
	
	private
	
	def add_user(user_id, is_editor = false, is_creator = false)
		group = ProjectGroup.new
		group.user_id = user_id
		group.project_creator = is_creator
		group.project_editor = is_editor
		project_groups << group
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
