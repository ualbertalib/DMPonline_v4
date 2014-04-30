class PlanSummary < ActiveRecord::Base

	#associations between tables
	belongs_to :plan
	belongs_to :section
	belongs_to :question
	belongs_to :answered_by, :class_name => User
	belongs_to :locked_by, :class_name => User
	
end
