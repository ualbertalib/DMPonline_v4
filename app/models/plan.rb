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
  		question = Question.find(qid)
		if answer.nil? && create_if_missing then
			answer = Answer.new
			answer.plan_id = id
			answer.question_id = qid
			answer.text = question.suggested_answer
			default_options = Array.new
			question.options.each do |option|
				if option.is_default
					default_options << option
				end
			end
			answer.options = default_options
		end
		return answer
	end
	
	def project_and_phase
		"#{project.title} #{version.phase.title}"
	end
	
	def sections
		sections = version.sections + project.organisation.all_sections
		return sections.sort_by &:number
	end
	
	def guidance_for_question(question)
		# pulls together guidance from various sources for question
		guidance_texts = Array.new
		guidance_texts << question.guidance
		theme_ids = question.theme_ids
		project.organisation.guidance_groups.each do |group|
			group.guidances.where("theme_id IN (?)", theme_ids).each do |guidance|
				guidance_texts << guidance.text
			end
		end
		project.guidance_groups.each do |group|
			group.guidances.where("theme_id IN (?)", theme_ids).each do |guidance|
				guidance_texts << guidance.text
			end
		end
		return guidance_texts
	end
	
	def can_edit(user_id)
		return project.can_edit(user_id)
	end
	
	def can_read(user_id)
		return project.can_read(user_id)
	end
	
	def status
		status = {
			"num_questions" => 0,
			"num_answers" => 0,
			"sections" => {},
			"questions" => {}
		}
		sections.each do |s|
			section_questions = 0
			section_answers = 0
			status["sections"][s.id] = {}
			status["sections"][s.id]["questions"] = Array.new
			s.questions.each do |q|
				status["num_questions"] += 1
				section_questions += 1
				status["sections"][s.id]["questions"] << q.id
				status["questions"][q.id] = {}
				answer = answer(q.id, false)
				if ! answer.nil? then
					status["questions"][q.id] = {
						"answer_id" => answer.id,
						"answer_created_at" => answer.created_at.to_i,
						"answer_text" => answer.text,
						"answer_option_ids" => answer.option_ids,
						"answered_by" => answer.user.name
					}
					status["num_answers"] += 1
					section_answers += 1
				else
					status["questions"][q.id] = {
						"answer_id" => nil,
						"answer_created_at" => nil,
						"answer_text" => nil,
						"answer_option_ids" => nil,
						"answered_by" => nil
					}
				end
 				status["sections"][s.id]["num_questions"] = section_questions
 				status["sections"][s.id]["num_answers"] = section_answers
			end
		end
		return status
	end
	
	def details
		details = {
			"project_title" => project.title,
			"phase_title" => version.phase.title,
			"sections" => {}
		}
		sections.order("number").each do |s|
			details["sections"][s.number] = {}
			details["sections"][s.number]["title"] = s.title
			details["sections"][s.number]["questions"] = {}
			s.questions.order("number").each do |q|
				details["sections"][s.number]["questions"][q.number] = {}
				details["sections"][s.number]["questions"][q.number]["question_text"] = q.text
				answer = answer(q.id, false)
				if ! answer.nil? then
					if q.multiple_choice then
						details["sections"][s.number]["questions"][q.number]["selections"] = {}
						answer.options.each do |o|
							details["sections"][s.number]["questions"][q.number]["selections"][o.number] = o.text
						end
					end
					details["sections"][s.number]["questions"][q.number]["answer_text"] = answer.text
				end
			end
		end
		return details
	end
	
	def locked(section_id, user_id)
		plan_section = plan_sections.where(:section_id => section_id).order("created_at DESC").first
		if plan_section.nil? then
			status = {
				"locked" => false,
				"current_user" => false,
				"locked_by" => nil,
				"timestamp" => nil,
				"id" => nil
			}
		else
			status = {
				"locked" => plan_section.release_time > Time.now,
				"current_user" => plan_section.user_id == user_id,
				"locked_by" => plan_section.user.name,
				"timestamp" => plan_section.updated_at,
				"id" => plan_section.id
			}
		end
	end
	
	def lock_all_sections(user_id)
		sections.each do |s|
			lock_section(s.id, user_id, 1800)
		end
	end
	
	def unlock_all_sections(user_id)
		plan_sections.where(:user_id => user_id).order("created_at DESC").each do |plan_section|
			unlock_plan_section(plan_section)
		end
	end
	
	def delete_recent_locks(user_id)
		plan_sections.where(:user_id => user_id, :created_at => 30.seconds.ago..Time.now).delete_all
	end
	
	def lock_section(section_id, user_id, release_time = 30)
		status = locked(section_id, user_id)
		if ! status["locked"] then
			plan_section = PlanSection.new
			plan_section.plan_id = id
			plan_section.section_id = section_id
			plan_section.release_time = Time.now + release_time.seconds
			plan_section.user_id = user_id
			plan_section.save
		elsif status["current_user"] then
			plan_section = PlanSection.find(status["id"])
			plan_section.release_time = Time.now + release_time.seconds
			plan_section.save
		else
			return false
		end
	end
	
	def unlock_section(section_id, user_id)
		plan_section = plan_sections.where(:section_id => section_id, :user_id => user_id).order("created_at DESC").first
		unlock_plan_section(plan_section, user_id)
	end
	
	def unlock_plan_section(plan_section, user_id)
		if plan_section.release_time > Time.now then
			plan_section.release_time = Time.now
			plan_section.save
		else
			return false
		end
	end
end
