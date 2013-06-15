class Dmptemplate < ActiveRecord::Base
  
    #associations between tables
    has_many :phases
  
  attr_accessible :org_id, :template_desc, :template_published, :template_title, :user_id
  
 
  def to_s
    "#{title}"
  end
end
