class Dmptemplate < ActiveRecord::Base
  attr_accessible :description, :published, :title
  has_many :phases
  
  def to_s
  	"#{title}"
  end
end
