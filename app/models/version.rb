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
end
