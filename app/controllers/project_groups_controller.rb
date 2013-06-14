class ProjectGroupsController < ApplicationController
  # GET /project_groups
  # GET /project_groups.json
  def index
    @project_groups = ProjectGroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @project_groups }
    end
  end

  # GET /project_groups/1
  # GET /project_groups/1.json
  def show
    @project_group = ProjectGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project_group }
    end
  end

  # GET /project_groups/new
  # GET /project_groups/new.json
  def new
    @project_group = ProjectGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project_group }
    end
  end

  # GET /project_groups/1/edit
  def edit
    @project_group = ProjectGroup.find(params[:id])
  end

  # POST /project_groups
  # POST /project_groups.json
  def create
    @project_group = ProjectGroup.new(params[:project_group])

    respond_to do |format|
      if @project_group.save
        format.html { redirect_to @project_group, notice: 'Project group was successfully created.' }
        format.json { render json: @project_group, status: :created, location: @project_group }
      else
        format.html { render action: "new" }
        format.json { render json: @project_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /project_groups/1
  # PUT /project_groups/1.json
  def update
    @project_group = ProjectGroup.find(params[:id])

    respond_to do |format|
      if @project_group.update_attributes(params[:project_group])
        format.html { redirect_to @project_group, notice: 'Project group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /project_groups/1
  # DELETE /project_groups/1.json
  def destroy
    @project_group = ProjectGroup.find(params[:id])
    @project_group.destroy

    respond_to do |format|
      format.html { redirect_to project_groups_url }
      format.json { head :no_content }
    end
  end
end
