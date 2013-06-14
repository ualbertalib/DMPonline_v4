class Dmptemplate < ActiveRecord::Base
  attr_accessible :org_id, :template_desc, :template_published, :template_title, :user_id
  
  has_many :phases
  
  def to_s
    "#{title}"
  end
end
