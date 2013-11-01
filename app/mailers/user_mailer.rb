class UserMailer < ActionMailer::Base
	
	def sharing_notification(project_group)
		@project_group = project_group
		mail(to: @project_group.user.email, subject: "You have been given access to a Data Management Plan")
	end
end