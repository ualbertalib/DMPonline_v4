class Plan < ActiveRecord::Base
  attr_accessible :locked, :project_id, :version_id, :version

  #associations between tables
  belongs_to :project
  has_many :answers
  belongs_to :version
  accepts_nested_attributes_for :project
  accepts_nested_attributes_for :answers
  accepts_nested_attributes_for :version
  
end
