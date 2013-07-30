class Section < ActiveRecord::Base
  
  #associations between tables
  belongs_to :version
  has_many :questions
  has_many :plan_sections
  
  #Link the child's data
  accepts_nested_attributes_for :questions
  
  attr_accessible :organisation_id, :description, :number, :title, :version_id
  
  def to_s
    "#{title}"
  end
  
end
