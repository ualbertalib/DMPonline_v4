class Answer < ActiveRecord::Base
  attr_accessible :text, :plan_id, :question_id, :user_id
  belongs_to :plan_section
end
