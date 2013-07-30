class Plan < ActiveRecord::Base

	extend FriendlyId
	
	attr_accessible :locked, :project_id, :version_id, :version, :plan_sections

	#associations between tables
	belongs_to :project
	has_many :answers
	has_many :plan_sections
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
			"sections" => {},
			"questions" => {}
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
					status["questions"][q.id] = {
						"answer_id" => answer.id,
						"answer_created_at" => answer.created_at.to_i,
						"answer_text" => answer.text,
						"answer_option_ids" => answer.option_ids
					}
					status["num_answers"] += 1
					section_answers += 1
				end
 				status["sections"][s.id]["num_questions"] = section_questions
 				status["sections"][s.id]["num_answers"] = section_answers
			end
		end
		return status
	end
	
	def locked(section_id)
		plan_section = plan_sections.where(:section_id => section_id).order("created_at DESC").first
		if plan_section.nil? then
			status = {
				"locked" => false,
				"user_id" => nil,
				"timestamp" => nil
			}
			return status
		elsif plan_section.locked then
			status = {
				"locked" => true,
				"user_id" => plan_section.user_id,
				"timestamp" => plan_section.created_at
			}
			return status
		else
			status = {
				"locked" => false,
				"user_id" => plan_section.user_id,
				"timestamp" => plan_section.updated_at
			}
			return status
		end
	end
	
	def lock_all_sections(user_id)
		version.sections.each do |s|
			lock_section(s.id, user_id)
		end
	end
	
	def unlock_all_sections(user_id)
		plan_sections.where(:user_id => user_id).order("created_at DESC").each do |plan_section|
			unlock_plan_section(plan_section)
		end
	end
	
	def delete_recent_locks(user_id)
		plan_sections.where(:user_id => user_id, :created_at => 10.seconds.ago..Time.now).delete_all
	end
	
	def lock_section(section_id, user_id)
		status = locked(section_id)
		if (! status["locked"]) then
			plan_section = PlanSection.new
			plan_section.plan_id = id
			plan_section.section_id = section_id
			plan_section.locked = true
			plan_section.user_id = user_id
			plan_section.save
			return true
		else
			return false
		end
	end
	
	def unlock_section(section_id, user_id)
		plan_section = plan_sections.where(:section_id => section_id, :user_id => user_id).order("created_at DESC").first
		unlocked = unlock_plan_section(plan_section)
	end
	
	def unlock_plan_section(plan_section)
		if plan_section.locked then
			plan_section.locked = false
			plan_section.save
			return true
		else
			return false
		end
	end
end
