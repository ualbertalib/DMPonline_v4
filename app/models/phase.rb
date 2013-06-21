class Phase < ActiveRecord::Base

  #associations between tables
  belongs_to :dmptemplate
  has_many :version
  
  attr_accessible :description, :order, :title, :dmptemplate_id
  
  def to_s
  	"#{title}"
  end
end
