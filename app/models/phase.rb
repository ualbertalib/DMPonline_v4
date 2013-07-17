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
end
