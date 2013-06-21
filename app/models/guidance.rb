class Guidance < ActiveRecord::Base
  attr_accessible :file_id, :text, :organisation_id, :theme_id

	#associations between tables
	has_one :theme
	has_one :organisation

end
