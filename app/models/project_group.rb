class ProjectGroup < ActiveRecord::Base
  attr_accessible :project_creator, :project_editor, :project_id, :user_id
end
