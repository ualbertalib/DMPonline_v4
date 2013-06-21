class Plan < ActiveRecord::Base
  attr_accessible :locked, :project_id, :version_id, :version
  has_many :plan_sections
  belongs_to :project
  belongs_to :version
  
  # Need method to retrieve template (and hence sections and questions)
  # Need method to retrieve plan_sections
end
