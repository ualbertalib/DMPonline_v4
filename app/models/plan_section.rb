class PlanSection < ActiveRecord::Base
  attr_accessible :plan_id, :at, :edit, :section_id, :user_editing_id

  #associations between tables
  has_one :section
  belongs_to :plan
  
end
