class Guidance < ActiveRecord::Base
  attr_accessible :file_id, :text, :guidance_group_id, :theme_id

	#associations between tables
	belongs_to :theme
	has_and_belongs_to_many :guidance_groups

end
