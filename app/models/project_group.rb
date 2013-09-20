class ProjectGroup < ActiveRecord::Base

  #associations between tables
  belongs_to :project
  belongs_to :user
  
  attr_accessible :project_creator, :project_editor, :project_id, :user_id, :email
  
  def email
  	unless user.nil? 
  		return user.email
  	end
  end
  
  def email=(new_email)
  	unless User.find_by_email(email).nil? then
		user = User.find_by_email(email)
	end
  end
end
