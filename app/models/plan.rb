class Plan < ActiveRecord::Base

	extend FriendlyId
	
	attr_accessible :locked, :project_id, :version_id, :version

	#associations between tables
	belongs_to :project
	has_many :answers
	belongs_to :version
	accepts_nested_attributes_for :project
	accepts_nested_attributes_for :answers
	accepts_nested_attributes_for :version
	
	friendly_id :project_and_phase, use: :slugged
  
	def answer(qid, create_if_missing = true)
  		answer = answers.where(:question_id => qid).order("created_at DESC").first
		if answer.nil? && create_if_missing then
			answer = Answer.new
			answer.plan_id = id
			answer.question_id = qid
		end
		return answer
	end
	
	def project_and_phase
		"#{project.title} #{version.phase.title}"
	end
	
	def status
		status = {
			"num_questions" => 0,
			"num_answers" => 0,
			"sections" => {}
		}
		version.sections.each do |s|
			section_questions = 0
			section_answers = 0
			status["sections"][s.id] = {}
			s.questions.each do |q|
				status["num_questions"] += 1
				section_questions += 1
				answer = answer(q.id, false)
				if ! answer.nil? then
					status["num_answers"] += 1
					section_answers += 1
				end
 				status["sections"][s.id]["num_questions"] = section_questions
 				status["sections"][s.id]["num_answers"] = section_answers
			end
		end
		return status
	end
end
