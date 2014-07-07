class Theme < ActiveRecord::Base

  #associations between tables
  has_and_belongs_to_many :questions  
  has_many :guidances
	has_and_belongs_to_many :guidances, join_table: "themes_in_guidance"
  
  
  accepts_nested_attributes_for :guidances
  
  attr_accessible :guidance_ids
  attr_accessible :description, :title, :locale
  
  def to_s
  	title
  end
  
end
