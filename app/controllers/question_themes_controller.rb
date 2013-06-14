class QuestionThemesController < ApplicationController
  # GET /question_themes
  # GET /question_themes.json
  def index
    @question_themes = QuestionTheme.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @question_themes }
    end
  end

  # GET /question_themes/1
  # GET /question_themes/1.json
  def show
    @question_theme = QuestionTheme.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @question_theme }
    end
  end

  # GET /question_themes/new
  # GET /question_themes/new.json
  def new
    @question_theme = QuestionTheme.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @question_theme }
    end
  end

  # GET /question_themes/1/edit
  def edit
    @question_theme = QuestionTheme.find(params[:id])
  end

  # POST /question_themes
  # POST /question_themes.json
  def create
    @question_theme = QuestionTheme.new(params[:question_theme])

    respond_to do |format|
      if @question_theme.save
        format.html { redirect_to @question_theme, notice: 'Question theme was successfully created.' }
        format.json { render json: @question_theme, status: :created, location: @question_theme }
      else
        format.html { render action: "new" }
        format.json { render json: @question_theme.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /question_themes/1
  # PUT /question_themes/1.json
  def update
    @question_theme = QuestionTheme.find(params[:id])

    respond_to do |format|
      if @question_theme.update_attributes(params[:question_theme])
        format.html { redirect_to @question_theme, notice: 'Question theme was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @question_theme.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /question_themes/1
  # DELETE /question_themes/1.json
  def destroy
    @question_theme = QuestionTheme.find(params[:id])
    @question_theme.destroy

    respond_to do |format|
      format.html { redirect_to question_themes_url }
      format.json { head :no_content }
    end
  end
end
