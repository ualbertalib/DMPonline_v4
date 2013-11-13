class Dmptemplate < ActiveRecord::Base
  attr_accessible :organisation_id, :description, :published, :title, :user_id, :locale, :is_default
  
  #associations between tables
  has_many :phases
  belongs_to :organisation
  has_many :projects
  has_many :guidances
  
  accepts_nested_attributes_for :phases
  accepts_nested_attributes_for :organisation
  accepts_nested_attributes_for :projects
    
  def to_s
    "#{title}"
  end
  
  def self.templates_org_type(ot)
    new_org_obejcts = OrganisationType.find_by_name(ot).organisations
    
    org_templates = Array.new
    new_org_obejcts.each do |neworg|
       org_templates += neworg.dmptemplates.where("published = ?", true)
    end
    
    return org_templates
   end 

end
