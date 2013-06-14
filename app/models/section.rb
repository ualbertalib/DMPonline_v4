class Section < ActiveRecord::Base
  
  #associations between tables
  belongs_to :version
  has_many :questions
  
  attr_accessible :org_id, :section_desc, :section_order, :section_title, :version_id
  
  def to_s
    "#{title}"
  end
  
end
