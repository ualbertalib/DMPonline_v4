class Dmptemplate < ActiveRecord::Base
  attr_accessible :organisation_id, :description, :published, :title, :user_id, :locale
  
  #associations between tables
  has_many :phases
  belongs_to :organisation
  has_many :projects
  
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
  
  #retrieves info on a specific template belonging to an organisation
  def self.templates_of_org(org_id)
	   org_template = Dmptemplate.where("organisation_id = ? AND published = ?", org_id, true)
    return org_template
      
  end

end
