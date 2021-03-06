class Version < ActiveRecord::Base
  
  translates :title, :description 
  #associations between tables
  belongs_to :phase
  
  has_many :sections, :dependent => :destroy
  has_many :questions, :through => :sections, :dependent => :destroy
  has_many :plans
  
  #Link the data
	accepts_nested_attributes_for :phase
  accepts_nested_attributes_for :sections,  :allow_destroy => true 
  
  attr_accessible :description, :number, :published, :title, :phase_id
  
  def to_s
  	"#{title}"
  end
  
  
  
  def global_sections
  	sections.find_all_by_organisation_id(phase.dmptemplate.organisation_id)
  end
  
  amoeba do
    include_field :sections
    include_field :questions
    set :published => 'false'
    prepend :title => "Copy of " 
  end
 
 	
end
