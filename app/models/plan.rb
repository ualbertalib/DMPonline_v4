class Plan < ActiveRecord::Base

  #associations between tables
  belongs_to :project
  has_many :answer
  has_one :version
  
  attr_accessible :plan_locked, :project_id, :version_id
end
