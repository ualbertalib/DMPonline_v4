class Project < ActiveRecord::Base
	attr_accessible :dmptemplate_id, :locked, :note, :title

   #associations between tables
   belongs_to :dmptemplate
   has_many :plans
   
end
