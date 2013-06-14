class FileTypesController < ApplicationController
  # GET /file_types
  # GET /file_types.json
  def index
    @file_types = FileType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @file_types }
    end
  end

  # GET /file_types/1
  # GET /file_types/1.json
  def show
    @file_type = FileType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @file_type }
    end
  end

  # GET /file_types/new
  # GET /file_types/new.json
  def new
    @file_type = FileType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @file_type }
    end
  end

  # GET /file_types/1/edit
  def edit
    @file_type = FileType.find(params[:id])
  end

  # POST /file_types
  # POST /file_types.json
  def create
    @file_type = FileType.new(params[:file_type])

    respond_to do |format|
      if @file_type.save
        format.html { redirect_to @file_type, notice: 'File type was successfully created.' }
        format.json { render json: @file_type, status: :created, location: @file_type }
      else
        format.html { render action: "new" }
        format.json { render json: @file_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /file_types/1
  # PUT /file_types/1.json
  def update
    @file_type = FileType.find(params[:id])

    respond_to do |format|
      if @file_type.update_attributes(params[:file_type])
        format.html { redirect_to @file_type, notice: 'File type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @file_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /file_types/1
  # DELETE /file_types/1.json
  def destroy
    @file_type = FileType.find(params[:id])
    @file_type.destroy

    respond_to do |format|
      format.html { redirect_to file_types_url }
      format.json { head :no_content }
    end
  end
end
