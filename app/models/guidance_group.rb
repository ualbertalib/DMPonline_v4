class GuidanceGroup < ActiveRecord::Base
  	attr_accessible :organisation_id, :name

	#associations between tables
	belongs_to :organisation
	has_and_belongs_to_many :guidances
	has_and_belongs_to_many :projects

end
