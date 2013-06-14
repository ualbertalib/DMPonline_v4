class PlanSectionsController < ApplicationController
  # GET /plan_sections
  # GET /plan_sections.json
  def index
    @plan_sections = PlanSection.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @plan_sections }
    end
  end

  # GET /plan_sections/1
  # GET /plan_sections/1.json
  def show
    @plan_section = PlanSection.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @plan_section }
    end
  end

  # GET /plan_sections/new
  # GET /plan_sections/new.json
  def new
    @plan_section = PlanSection.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @plan_section }
    end
  end

  # GET /plan_sections/1/edit
  def edit
    @plan_section = PlanSection.find(params[:id])
  end

  # POST /plan_sections
  # POST /plan_sections.json
  def create
    @plan_section = PlanSection.new(params[:plan_section])

    respond_to do |format|
      if @plan_section.save
        format.html { redirect_to @plan_section, notice: 'Plan section was successfully created.' }
        format.json { render json: @plan_section, status: :created, location: @plan_section }
      else
        format.html { render action: "new" }
        format.json { render json: @plan_section.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /plan_sections/1
  # PUT /plan_sections/1.json
  def update
    @plan_section = PlanSection.find(params[:id])

    respond_to do |format|
      if @plan_section.update_attributes(params[:plan_section])
        format.html { redirect_to @plan_section, notice: 'Plan section was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @plan_section.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plan_sections/1
  # DELETE /plan_sections/1.json
  def destroy
    @plan_section = PlanSection.find(params[:id])
    @plan_section.destroy

    respond_to do |format|
      format.html { redirect_to plan_sections_url }
      format.json { head :no_content }
    end
  end
end
