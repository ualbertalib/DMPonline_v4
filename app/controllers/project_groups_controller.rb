class ProjectGroupsController < ApplicationController
	
	def create
		@project_group = ProjectGroup.new(params[:project_group])
		if (user_signed_in?) && @project_group.project.editable_by(current_user.id) then
			respond_to do |format|
				message = 'User added to project'
			  	if @project_group.save
					if @project_group.user.nil? then
						if User.find_by_email(params[:project_group][:email]).nil? then
							User.invite!(:email => params[:project_group][:email])
							message = 'Invitation issued successfully.'
						end
						@project_group.user = User.find_by_email(params[:project_group][:email])
						@project_group.save
					end
					format.html { redirect_to @project_group.project, notice: message }
					format.json { render json: @project_group, status: :created, location: @project_group }
			  	else
					format.html { render action: "new" }
					format.json { render json: @project_group.errors, status: :unprocessable_entity }
			  	end
			end
		end
	end
	
end