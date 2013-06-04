class Section < ActiveRecord::Base
  belongs_to :version
  attr_accessible :description, :order, :published, :title, :version_id
  
  def to_s
  	"#{title}"
  end
end
