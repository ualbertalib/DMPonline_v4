class GuidancesController < ApplicationController
  # GET /guidances
  # GET /guidances.json
  def index
    @guidances = Guidance.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @guidances }
    end
  end

  # GET /guidances/1
  # GET /guidances/1.json
  def show
    @guidance = Guidance.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @guidance }
    end
  end

  # GET /guidances/new
  # GET /guidances/new.json
  def new
    @guidance = Guidance.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @guidance }
    end
  end

  # GET /guidances/1/edit
  def edit
    @guidance = Guidance.find(params[:id])
  end

  # POST /guidances
  # POST /guidances.json
  def create
    @guidance = Guidance.new(params[:guidance])

    respond_to do |format|
      if @guidance.save
        format.html { redirect_to @guidance, notice: 'Guidance was successfully created.' }
        format.json { render json: @guidance, status: :created, location: @guidance }
      else
        format.html { render action: "new" }
        format.json { render json: @guidance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /guidances/1
  # PUT /guidances/1.json
  def update
    @guidance = Guidance.find(params[:id])

    respond_to do |format|
      if @guidance.update_attributes(params[:guidance])
        format.html { redirect_to @guidance, notice: 'Guidance was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @guidance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /guidances/1
  # DELETE /guidances/1.json
  def destroy
    @guidance = Guidance.find(params[:id])
    @guidance.destroy

    respond_to do |format|
      format.html { redirect_to guidances_url }
      format.json { head :no_content }
    end
  end
end
