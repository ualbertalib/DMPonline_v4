class Version < ActiveRecord::Base
  belongs_to :phase
  has_many :sections
  has_many :plans
  attr_accessible :description, :order, :published, :title, :phase_id, :phase
  
  def to_s
  	"#{title}"
  end
end
