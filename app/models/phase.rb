class Phase < ActiveRecord::Base
  belongs_to :dmptemplate
  has_many :versions
  attr_accessible :description, :order, :title, :dmptemplate_id
  
  def to_s
  	"#{title}"
  end
end
