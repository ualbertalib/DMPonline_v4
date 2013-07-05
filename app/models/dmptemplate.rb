class Dmptemplate < ActiveRecord::Base
  attr_accessible :organisation_id, :description, :published, :title, :user_id, :locale
  
  #associations between tables
  has_many :phases
    
  def to_s
    "#{title}"
  end
end
