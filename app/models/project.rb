class Project < ActiveRecord::Base
  attr_accessible :dmptemplate_id, :locked, :note, :title
end
