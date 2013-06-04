class Version < ActiveRecord::Base
  belongs_to :phase
  has_many :sections
  attr_accessible :description, :order, :published, :title, :phase_id
  
  def to_s
  	"#{title}"
  end
end
