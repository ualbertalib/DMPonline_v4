class ProjectGroup < ActiveRecord::Base

  #associations between tables
  belongs_to :project
  belongs_to :user
  
  attr_accessible :project_creator, :project_editor, :project_id, :user_id
end
