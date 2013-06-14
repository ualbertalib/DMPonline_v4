class Project < ActiveRecord::Base
  attr_accessible :dmptemplate_id, :project_locked, :project_note, :project_title
end
