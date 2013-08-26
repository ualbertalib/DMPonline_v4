class Organisation < ActiveRecord::Base
  
  #associations between tables
  has_many :dmptemplates
  has_one :organisation_type
  has_many :guidance_groups
  belongs_to :parent, :class_name => 'Organisation'
  has_many :children, :class_name => 'Organisation', :foreign_key => 'parent_id'
  
  accepts_nested_attributes_for :organisation_type
  accepts_nested_attributes_for :dmptemplates
  
  attr_accessible :abbreviation, :banner_file_id, :description, :domain, :logo_file_id, :name, :stylesheet_file_id, :target_url, :organisation_type_id, :wayfless_entity


  #retrieves info off a child org 
  def self.has_children(parent_org_id)
    org_child = Organisation.where(parent_id: parent_org_id)
    return org_child
  end
   
    
  def self.other_organisations
    org_types = [I18n.t('helpers.org_type.school'), I18n.t('helpers.org_type.organisation')]
    organisations_list = []
    org_types.each do |ot|
      new_org_obejct = OrganisationType.find_by_name(ot)
      organisations_list = organisations_list + new_org_obejct.organisations
      
    end
    return organisations_list
  end
  
end
