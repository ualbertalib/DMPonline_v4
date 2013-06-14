class Plan < ActiveRecord::Base
  attr_accessible :plan_locked, :project_id, :version_id
end
