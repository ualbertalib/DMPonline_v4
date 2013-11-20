class Guidance < ActiveRecord::Base
  attr_accessible :file_id, :text, :theme_id, :dmptemplate_id
  
  attr_accessible :guidance_group_ids

	#associations between tables
	belongs_to :theme
	belongs_to :dmptemplate
	has_and_belongs_to_many :guidance_groups, join_table: "guidance_in_group"

end
