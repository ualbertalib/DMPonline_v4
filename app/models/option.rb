class Option < ActiveRecord::Base
  
	#associations between tables
	belongs_to :question
	has_and_belongs_to_many :answers
	attr_accessible :text, :question_id, :is_default, :number
  
	def to_s
		"#{text}"
	end
end