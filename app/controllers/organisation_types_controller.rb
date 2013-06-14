class OrganisationTypesController < ApplicationController
  # GET /organisation_types
  # GET /organisation_types.json
  def index
    @organisation_types = OrganisationType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @organisation_types }
    end
  end

  # GET /organisation_types/1
  # GET /organisation_types/1.json
  def show
    @organisation_type = OrganisationType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @organisation_type }
    end
  end

  # GET /organisation_types/new
  # GET /organisation_types/new.json
  def new
    @organisation_type = OrganisationType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @organisation_type }
    end
  end

  # GET /organisation_types/1/edit
  def edit
    @organisation_type = OrganisationType.find(params[:id])
  end

  # POST /organisation_types
  # POST /organisation_types.json
  def create
    @organisation_type = OrganisationType.new(params[:organisation_type])

    respond_to do |format|
      if @organisation_type.save
        format.html { redirect_to @organisation_type, notice: 'Organisation type was successfully created.' }
        format.json { render json: @organisation_type, status: :created, location: @organisation_type }
      else
        format.html { render action: "new" }
        format.json { render json: @organisation_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /organisation_types/1
  # PUT /organisation_types/1.json
  def update
    @organisation_type = OrganisationType.find(params[:id])

    respond_to do |format|
      if @organisation_type.update_attributes(params[:organisation_type])
        format.html { redirect_to @organisation_type, notice: 'Organisation type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @organisation_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organisation_types/1
  # DELETE /organisation_types/1.json
  def destroy
    @organisation_type = OrganisationType.find(params[:id])
    @organisation_type.destroy

    respond_to do |format|
      format.html { redirect_to organisation_types_url }
      format.json { head :no_content }
    end
  end
end
