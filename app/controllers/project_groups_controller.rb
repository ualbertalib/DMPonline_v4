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
					flash[:notice] = message
					format.html { redirect_to :controller => 'projects', :action => 'share', :id => @project_group.project.slug }
					format.json { render json: @project_group, status: :created, location: @project_group }
			  	else
					format.html { render action: "new" }
					format.json { render json: @project_group.errors, status: :unprocessable_entity }
			  	end
			end
		else
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end
	end
	
	def update
    	@project_group = ProjectGroup.find(params[:id])
    	if (user_signed_in?) && @project_group.project.editable_by(current_user.id) then
			respond_to do |format|
				if @project_group.update_attributes(params[:project_group])
					flash[:notice] = 'Sharing details successfully updated.'
					format.html { redirect_to :controller => 'projects', :action => 'share', :id => @project_group.project.slug }
					format.json { head :no_content }
				else
					format.html { render action: "edit" }
					format.json { render json: @project_group.errors, status: :unprocessable_entity }
				 end
			end
    	else
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end
  	end

	def destroy
		@project_group = ProjectGroup.find(params[:id])
		if (user_signed_in?) && @project_group.project.editable_by(current_user.id) then
			@project_group.destroy
			respond_to do |format|
				flash[:notice] = 'Access removed'
				format.html { redirect_to :controller => 'projects', :action => 'share', :id => @project_group.project.slug }
				format.json { head :no_content }
			end
		else
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end
	end
	
end