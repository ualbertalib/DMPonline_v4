class Page < ActiveRecord::Base

  #associations between tables
  belongs_to :organisation
  
  attr_accessible :org_id, :pag_body_text, :pag_location, :pag_menu, :pag_menu_position, :pag_public, :pag_slug, :pag_target_url, :pag_title
end
