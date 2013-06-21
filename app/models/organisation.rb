class Organisation < ActiveRecord::Base
  
  #associations between tables
  has_one :organisation_type  
  
  attr_accessible :abbreviation, :banner_file_id, :description, :domain, :logo_file_id, :name, :stylesheet_file_id, :target_url, :type_id, :wayfless_entity
end
