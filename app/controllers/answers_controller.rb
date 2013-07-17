class AnswersController < ApplicationController
  # GET /answers
  # GET /answers.json
  def index
    @answers = Answer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @answers }
    end
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
    @answer = Answer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @answer }
    end
  end

  # GET /answers/new
  # GET /answers/new.json
  def new
    @answer = Answer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @answer }
    end
  end

  # GET /answers/1/edit
  def edit
    @answer = Answer.find(params[:id])
  end

  # POST /answers
  # POST /answers.json
  def create
    @answer = Answer.new(params[:answer])
    old_answer = @answer.plan.answer(@answer.question_id, false)
    proceed = false
    if ! @answer.question.multiple_choice then
		@answer.text = params["answer_text_#{@answer.question_id}".to_sym]
		if (old_answer.nil? && @answer.text != "") || ((!old_answer.nil?) && (old_answer.text != @answer.text)) then
			proceed = true
		end
	else
		if (old_answer.nil? && @answer.option_ids.count > 0) || ((!old_answer.nil?) && (old_answer.option_ids - @answer.option_ids).count > 0) then
			proceed = true
		end
	end
	if proceed
		respond_to do |format|
		  if @answer.save
			format.html { redirect_to :back, status: :found, notice: 'Answer was successfully recorded.' }
			format.json { render json: @answer, status: :created, location: @answer }
		  else
			format.html { render action: "new" }
			format.json { render json: @answer.errors, status: :unprocessable_entity }
		  end
		end
	end
  end

  # PUT /answers/1
  # PUT /answers/1.json
  def update
    @answer = Answer.find(params[:id])

    respond_to do |format|
      if @answer.update_attributes(params[:answer])
        format.html { redirect_to @answer, notice: 'Answer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy

    respond_to do |format|
      format.html { redirect_to answers_url }
      format.json { head :no_content }
    end
  end
end
