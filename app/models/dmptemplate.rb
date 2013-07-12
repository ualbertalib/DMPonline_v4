class Dmptemplate < ActiveRecord::Base
  attr_accessible :organisation_id, :description, :published, :title, :user_id, :locale
  
  #associations between tables
  has_many :phases
  
  accepts_nested_attributes_for :phases
    
  def to_s
    "#{title}"
  end
  
end
