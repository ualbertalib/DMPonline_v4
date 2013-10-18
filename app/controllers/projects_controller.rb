class ProjectsController < ApplicationController
	# GET /projects
	# GET /projects.json
	def index
		if user_signed_in? then
			@projects = Project.projects_for_user(current_user.id)
			respond_to do |format|
				format.html # index.html.erb
				format.json { render json: @projects }
			end
		else
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end
	end

	# GET /projects/1
	# GET /projects/1.json
	def show
		@project = Project.find(params[:id])
		@show_form = false
		if params[:show_form] == "yes" then
			@show_form = true
		end
		if user_signed_in? && @project.readable_by(current_user.id)then
			respond_to do |format|
				format.html # show.html.erb
				format.json { render json: @project }
			end
		else
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end
	end

	# GET /projects/new
	# GET /projects/new.json
	def new
		if user_signed_in? then
			@project = Project.new
			respond_to do |format|
			  format.html # new.html.erb
			  format.json { render json: @project }
			end
		else
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end
	end

	# GET /projects/1/edit
	def edit
		@project = Project.find(params[:id])
		unless user_signed_in? && @project.editable_by(current_user.id) then
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end
	end
	
	def share
		@project = Project.find(params[:id])
		unless user_signed_in? && @project.administerable_by(current_user.id) then
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end
	end
	
	def export
		@project = Project.find(params[:id])
		unless user_signed_in? then
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end
	end

	# POST /projects
	# POST /projects.json
	def create
    	if user_signed_in? then
			@project = Project.new(params[:project])
			if @project.dmptemplate.nil? && params[:project][:funder_id] != "" then # this shouldn't be necessary - see setter for funder_id in project.rb
				funder = Organisation.find(params[:project][:funder_id])
				if funder.dmptemplates.count == 1 then
					@project.dmptemplate = funder.dmptemplates.first
				end
			elsif @project.dmptemplate.nil? then
				if @project.organisation.nil? || @project.organisation.dmptemplates.first.nil? then
					@project.dmptemplate = Dmptemplate.find_by_is_default(true)
				else
					@project.dmptemplate = @project.organisation.dmptemplates.first
				end
			end
			@project.principal_investigator = current_user.name(false)
			@project.title = I18n.t('helpers.project.my_project_name')+' ('+@project.dmptemplate.title+')'
			@project.assign_creator(current_user.id)
			respond_to do |format|
				if @project.save
					format.html { redirect_to({:action => "show", :id => @project.slug, :show_form => "yes"}, {:notice => 'Project was successfully created.'}) }
					format.json { render json: @project, status: :created, location: @project }
				else
					format.html { render action: "new" }
					format.json { render json: @project.errors, status: :unprocessable_entity }
				end
			end
		else
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end
	end

	# PUT /projects/1
	# PUT /projects/1.json
	def update
		@project = Project.find(params[:id])
		if user_signed_in? && @project.editable_by(current_user.id) then
			respond_to do |format|
				if @project.update_attributes(params[:project])
					format.html { redirect_to @project, notice: 'Project was successfully updated.' }
					format.json { head :no_content }
				else
					format.html { render action: "edit" }
					format.json { render json: @project.errors, status: :unprocessable_entity }
				end
			end
		else
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end
	end

	# DELETE /projects/1
	# DELETE /projects/1.json
	def destroy
		@project = Project.find(params[:id])
		if user_signed_in? && @project.editable_by(current_user.id) then
			@project.destroy

			respond_to do |format|
				format.html { redirect_to projects_url }
				format.json { head :no_content }
			end
		else
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end
	end
end
