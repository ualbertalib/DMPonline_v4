class AnswersController < ApplicationController

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
end