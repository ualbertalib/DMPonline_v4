class Phase < ActiveRecord::Base

  #associations between tables
  belongs_to :dmptemplate
  has_many :versions
  
  #Link the child's data
  accepts_nested_attributes_for :versions
 
  attr_accessible :description, :number, :title, :dmptemplate_id
  
  def to_s
  	"#{title}"
  end
end
