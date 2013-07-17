class Project < ActiveRecord::Base

	extend FriendlyId

	attr_accessible :dmptemplate_id, :locked, :note, :title

	#associations between tables
	belongs_to :dmptemplate
	has_many :plans
	
	friendly_id :title, use: :slugged
end
