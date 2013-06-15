class Guidance < ActiveRecord::Base

   #associations between tables
   has_one :theme
   has_one :organisation
   
  attr_accessible :guidance_file_id, :guidance_text, :org_id, :theme_id
end
