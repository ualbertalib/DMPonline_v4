class DmptemplatesController < ApplicationController
  # GET /dmptemplates
  # GET /dmptemplates.json
  def index
    @dmptemplates = Dmptemplate.all()
   
   respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dmptemplates }
    end
  end

  # GET /dmptemplates/1
  # GET /dmptemplates/1.json
  def show
    @dmptemplate = Dmptemplate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dmptemplate }
    end
  end

  # GET /dmptemplates/new
  # GET /dmptemplates/new.json
  def new
    @dmptemplate = Dmptemplate.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dmptemplate }
    end
  end

  # GET /dmptemplates/1/edit
  def edit
    @dmptemplate = Dmptemplate.find(params[:id])
  end

  # POST /dmptemplates
  # POST /dmptemplates.json
  def create
    @dmptemplate = Dmptemplate.new(params[:dmptemplate])

    respond_to do |format|
      if @dmptemplate.save
        format.html { redirect_to @dmptemplate, notice: 'Template was successfully created.' }
        format.json { render json: @dmptemplate, status: :created, location: @dmptemplate }
      else
        format.html { render action: "new" }
        format.json { render json: @dmptemplate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dmptemplates/1
  # PUT /dmptemplates/1.json
  def update
    @dmptemplate = Dmptemplate.find(params[:id])

    respond_to do |format|
      if @dmptemplate.update_attributes(params[:dmptemplate])
        format.html { redirect_to @dmptemplate, notice: 'Template was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dmptemplate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dmptemplates/1
  # DELETE /dmptemplates/1.json
  def destroy
    @dmptemplate = Dmptemplate.find(params[:id])
    @dmptemplate.destroy

    respond_to do |format|
      format.html { redirect_to dmptemplates_url }
      format.json { head :no_content }
    end
  end
end
