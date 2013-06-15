class PlanSection < ActiveRecord::Base

  #associations between tables
  has_one :section
  belongs_to :plan
  
  attr_accessible :plan_id, :plan_section_at, :plan_section_edit, :section_id, :user_editing_id
end
