class Plan < ActiveRecord::Base
	
	attr_accessible :locked, :project_id, :version_id, :version, :plan_sections

	#associations between tables
	belongs_to :project
	has_many :answers
	has_many :plan_sections
	belongs_to :version
	accepts_nested_attributes_for :project
	accepts_nested_attributes_for :answers
	accepts_nested_attributes_for :version
	  
	def answer(qid, create_if_missing = true)
  		answer = answers.where(:question_id => qid).order("created_at DESC").first
  		question = Question.find(qid)
		if answer.nil? && create_if_missing then
			answer = Answer.new
			answer.plan_id = id
			answer.question_id = qid
			answer.text = question.default_value
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
	
	def sections
		unless project.organisation.nil? then
			sections = version.global_sections + project.organisation.all_sections(version_id)
		else
			sections = version.global_sections
		end
		return sections.uniq.sort_by &:number
	end
	
	def guidance_for_question(question)
	  # pulls together guidance from various sources for question
	  guidances = {}
	  theme_ids = question.theme_ids
	  unless project.organisation.nil? then
			# Guidance link to directly to a question
			question.guidances.each do |g_by_q|
				g_by_q.guidance_groups.each do |group|
			  	if group.organisation == project.organisation
			    	guidances["#{group.organisation.short_name} guidance for this question"] = g_by_q
			   	end
				end
	  	end
	  	project.organisation.guidance_groups.each do |group|
	    	group.guidances.each do |g|
	    		g.themes.where("id IN (?)", theme_ids).each do |gg|
	     			guidances["#{group.organisation.short_name} guidance on #{gg.title}"] = g
	     		end	
	    	end
	  	end
		end
		
		# guidance selected on 'create a plan' wizard
	  project.guidance_groups.each do |group|
	   	if group.organisation != project.organisation then
	    	group.guidances.where("theme_id IN (?)", theme_ids).each do |g|
	     		if group.dmptemplates == [] || g.dmptemplate_id == project.dmptemplate_id then
	      		guidances["#{group.organisation.short_name} guidance on #{g.theme.title}"] = g
	     		end
	    	end
	   	end
	  end
	  return guidances
 end
	
	def warning(option_id)
		if project.organisation.nil?
			return nil
		else
			return project.organisation.warning(option_id)
		end
	end
	
	def editable_by(user_id)
		return project.editable_by(user_id)
	end
	
	def readable_by(user_id)
		return project.readable_by(user_id)
	end
	
	def administerable_by(user_id)
		return project.readable_by(user_id)
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
		sections.sort_by(&:"number").each do |s|
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
		plan_section = plan_sections.where("section_id = ? AND user_id != ? AND release_time > ?", section_id, user_id, Time.now).last
		logger.debug("LOCK: #{plan_section.inspect}")	
		if plan_section.nil? then
			status = {
				"locked" => false,
				"locked_by" => nil,
				"timestamp" => nil,
				"id" => nil
			}
		else
			status = {
				"locked" => true,
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
		unless plan_section.nil?
			unlock_plan_section(plan_section, user_id)
		end
	end
	
	def unlock_plan_section(plan_section, user_id)
		if plan_section.release_time > Time.now then
			plan_section.release_time = Time.now
			plan_section.save
		else
			return false
		end
	end
	
	def latest_update
		if answers.any? then
			last_answered = answers.order("updated_at DESC").first.updated_at
			if last_answered > updated_at then
				return last_answered
			else
				return updated_at
			end
		else
			return updated_at
		end
	end
	
	def section_answers(section_id)
		section = Section.find(section_id)
 		section_questions = Array.new
 		counter = 0
 		section.questions.each do |q|
 			section_questions[counter] = {}
 			section_questions[counter]["id"] = q.id
 			section_questions[counter]["multiple_choice"] = q.multiple_choice
 			q_answer = answer(q.id, false)
 			if q_answer.nil? then
 				section_questions[counter]["answer_id"] = nil
 				if q.get_suggested_answer(project.organisation_id).nil? then
 					section_questions[counter]["answer_text"] = ""
 				else
 					section_questions[counter]["answer_text"] = q.default_value
 				end
 				section_questions[counter]["answer_timestamp"] = nil
 				section_questions[counter]["answer_options"] = Array.new
 			else
 				section_questions[counter]["answer_id"] = q_answer.id
 				section_questions[counter]["answer_text"] = q_answer.text
 				section_questions[counter]["answer_timestamp"] = q_answer.created_at
 				section_questions[counter]["answer_options"] = q_answer.options.pluck(:id)
 			end
 			counter = counter + 1
 		end
 		return section_questions
	end
end
