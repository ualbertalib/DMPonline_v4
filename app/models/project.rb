class Project < ActiveRecord::Base

   #associations between tables
   belongs_to :dmptemplate
   
  attr_accessible :dmptemplate_id, :project_locked, :project_note, :project_title
end
