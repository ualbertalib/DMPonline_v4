class Section < ActiveRecord::Base
  
  #associations between tables
  belongs_to :version
  has_many :questions
  
  attr_accessible :organisation_id, :description, :order, :title, :version_id
  
  def to_s
    "#{title}"
  end
  
end
