class Version < ActiveRecord::Base
  
  #associations between tables
  belongs_to :phase
  has_many :sections
  has_many :plans
  
  #Link the child's data
  accepts_nested_attributes_for :sections
  
  attr_accessible :description, :number, :published, :title, :phase_id
  
  def to_s
  	"#{title}"
  end
  
  def global_sections
  	sections.find_all_by_organisation_id(phase.dmptemplate.organisation_id)
  end
end
