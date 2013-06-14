class Organisation < ActiveRecord::Base
  
  has_one :organisation_type
  
  
  attr_accessible :org_abbre, :org_banner_file_id, :org_desc, :org_domain, :org_logo_file_id, :org_name, :org_stylesheet_file_id, :org_target_url, :org_type_id, :org_wayfless_entite
end
