class Answer < ActiveRecord::Base
  attr_accessible :answer_text, :plan_id, :question_id, :user_id
end
