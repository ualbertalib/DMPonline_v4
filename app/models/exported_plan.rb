class ExportedPlan < ActiveRecord::Base
  attr_accessible :plan_id, :user_id, :format
  
  #associations between tables
  belongs_to :plan
  belongs_to :user

end
