class PlanSection < ActiveRecord::Base
  attr_accessible :plan_id, :at, :edit, :section_id, :user_editing_id
  belongs_to :plan
  has_many :answers
  
end
