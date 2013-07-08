class Version < ActiveRecord::Base
  
  #associations between tables
  belongs_to :phase
  has_many :sections
  has_many :plans
  attr_accessible :description, :number, :published, :title, :phase_id
  accepts_nested_attributes_for :sections
  
  def to_s
  	"#{title}"
  end
end
