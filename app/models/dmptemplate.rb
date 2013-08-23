class Dmptemplate < ActiveRecord::Base
  attr_accessible :organisation_id, :description, :published, :title, :user_id, :locale
  
  #associations between tables
  has_many :phases
  has_one :organisation
  has_many :projects
  
  accepts_nested_attributes_for :phases
  accepts_nested_attributes_for :organisation
  accepts_nested_attributes_for :projects
    
  def to_s
    "#{title}"
  end
  
  #retrieves info on a specific template belonging to an organisation
  def self.templates_of_org(org_id)
    org_template = Dmptemplate.where(organisation_id: org_id)
    return org_template
      
  end
  
end
