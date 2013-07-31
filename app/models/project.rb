class Project < ActiveRecord::Base

	extend FriendlyId

	attr_accessible :dmptemplate_id, :locked, :note, :title

	#associations between tables
	belongs_to :dmptemplate
	has_many :plans
	has_and_belongs_to_many :guidance_groups
	
	friendly_id :title, use: :slugged
end
