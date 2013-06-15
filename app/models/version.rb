class Version < ActiveRecord::Base
  
  #associations between tables
  belongs_to :phase
  has_many :section
  
  attr_accessible :description, :order, :published, :title, :phase_id
  
  def to_s
  	"#{title}"
  end
end
