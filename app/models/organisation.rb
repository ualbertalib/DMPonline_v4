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

  def self.organisations_of_type(type_name)
    type = OrganisationType.find_by_name(type_name)
    return type.organisations
  end
  
end
