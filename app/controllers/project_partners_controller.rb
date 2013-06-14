class ProjectPartnersController < ApplicationController
  # GET /project_partners
  # GET /project_partners.json
  def index
    @project_partners = ProjectPartner.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @project_partners }
    end
  end

  # GET /project_partners/1
  # GET /project_partners/1.json
  def show
    @project_partner = ProjectPartner.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project_partner }
    end
  end

  # GET /project_partners/new
  # GET /project_partners/new.json
  def new
    @project_partner = ProjectPartner.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project_partner }
    end
  end

  # GET /project_partners/1/edit
  def edit
    @project_partner = ProjectPartner.find(params[:id])
  end

  # POST /project_partners
  # POST /project_partners.json
  def create
    @project_partner = ProjectPartner.new(params[:project_partner])

    respond_to do |format|
      if @project_partner.save
        format.html { redirect_to @project_partner, notice: 'Project partner was successfully created.' }
        format.json { render json: @project_partner, status: :created, location: @project_partner }
      else
        format.html { render action: "new" }
        format.json { render json: @project_partner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /project_partners/1
  # PUT /project_partners/1.json
  def update
    @project_partner = ProjectPartner.find(params[:id])

    respond_to do |format|
      if @project_partner.update_attributes(params[:project_partner])
        format.html { redirect_to @project_partner, notice: 'Project partner was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project_partner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /project_partners/1
  # DELETE /project_partners/1.json
  def destroy
    @project_partner = ProjectPartner.find(params[:id])
    @project_partner.destroy

    respond_to do |format|
      format.html { redirect_to project_partners_url }
      format.json { head :no_content }
    end
  end
end
