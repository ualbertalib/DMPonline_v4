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

	has_settings :export, class_name: 'Settings::Dmptemplate' do |s|
		s.key :export, defaults: { formatting: Settings::Dmptemplate::DEFAULT_FORMATTING }
	end

	alias_method :super_settings, :settings

	# Proxy through to the template settings (or defaults if this plan doesn't have
	# an associated template) if there are no settings stored for this plan.
	# `key` is required by rails-settings, so it's required here, too.
	def settings(key)
		self_settings = self.super_settings(key)
		return self_settings if self_settings.value?
		(self.project.try(:dmptemplate) || Dmptemplate.new).settings(key)
	end

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
		guidances = {}
		# If project org isn't nil, get guidance by theme from any "non-subset" groups belonging to project org
		unless project.organisation.nil? then
			project.organisation.guidance_groups.each do |group|
				if !group.optional_subset && (group.dmptemplates.pluck(:id).include?(project.dmptemplate_id) || group.dmptemplates.count == 0) then
					group.guidances.each do |guidance|
						guidance.themes.where("id IN (?)", question.theme_ids).each do |theme|
							guidances = self.add_guidance_to_array(guidances, group, theme, guidance)
						end
					end
				end
			end
		end
		# Get guidance by theme from any guidance groups selected on creation
		project.guidance_groups.each do |group|
			if group.dmptemplates.pluck(:id).include?(project.dmptemplate_id) || group.dmptemplates.count == 0 then
				group.guidances.each do |guidance|
					guidance.themes.where("id IN (?)", question.theme_ids).each do |theme|
						guidances = self.add_guidance_to_array(guidances, group, theme, guidance)
					end
				end
			end
		end
		# Get guidance by question where guidance group was selected on creation or if group is organisation default
		question.guidances.each do |guidance|
			guidance.guidance_groups.each do |group|
				if (group.organisation == project.organisation && !group.optional_subset) || project.guidance_groups.include?(group) then
					guidances = self.add_guidance_to_array(guidances, group, nil, guidance)
				end
			end
		end
		return guidances
	end

	def add_guidance_to_array(guidance_array, guidance_group, theme, guidance)
		logger.debug("Adding guidance to array: #{guidance_array}")
		if guidance_array[guidance_group].nil? then
			guidance_array[guidance_group] = {}
		end
		if theme.nil? then
			if guidance_array[guidance_group]["no_theme"].nil? then
				guidance_array[guidance_group]["no_theme"] = []
			end
			if !guidance_array[guidance_group]["no_theme"].include?(guidance) then
				guidance_array[guidance_group]["no_theme"].push(guidance)
			end
		else
			if guidance_array[guidance_group][theme].nil? then
				guidance_array[guidance_group][theme] = []
			end
			if !guidance_array[guidance_group][theme].include?(guidance) then
				guidance_array[guidance_group][theme].push(guidance)
			end
		end
		logger.debug("Added guidance to array: #{guidance_array}")
		return guidance_array
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
		lines = 0
		status = {
			"num_questions" => 0,
			"num_answers" => 0,
			"sections" => {},
			"questions" => {},
			"space_used" => 0 # percentage of available space in pdf used
		}
		sections.each do |s|
			lines += lines_from_text(s.title)
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

				lines += lines_from_text(q.text)
				lines += lines_from_text(answer.try(:text) || I18n.t('helpers.plan.export.pdf.question_not_answered'))

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

		lines += lines_from_text(I18n.t('helpers.plan.export.pdf.generated_by'))
		status['space_used'] = estimate_space_used(lines)
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
		plan_sections.where(:user_id => user_id).order("created_at DESC").each do |lock|
			lock.delete
		end
	end

	def delete_recent_locks(user_id)
		plan_sections.where(:user_id => user_id).each do |lock|
			lock.delete
		end
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
		plan_sections.where(:section_id => section_id, :user_id => user_id).order("created_at DESC").each do |lock|
			lock.delete
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
 				if q.suggested_answers.find_by_organisation_id(project.organisation_id).nil? then
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

private

	# Based on the total number of lines (lines_from_text calls from #status),
	# the font-size, margin heights and max pages, estimate a percentage of
	# how much space has been used.
	# This is highly dependent on the layout in the pdf. A more accurate approach
	# would be to render the pdf and check how much space had been used, but that
	# could be very slow.
	# NOTE: This is only an estimate, rounded up to the nearest 5%; it is intended
	# for guidance when editing plan data, not to be 100% accurate.
	def estimate_space_used(lines)
		@formatting ||= self.settings(:export).formatting

		return 0 unless @formatting[:font_size] > 0

		# vertical height of line + leading (ignore difference in heading sizes for now)
		line_height    = (0.35278 * @formatting[:font_size]) * 2 # * 2 to include leading
		margin_height  = @formatting[:margin][:top].to_i + @formatting[:margin][:bottom].to_i
		page_height    = 297 # For A4 portrait
		max_pages      = 3 # settings(:export).max_pages
		lines_per_page = ((page_height - margin_height) / line_height).floor
		total_pages    = lines / lines_per_page.to_f

		percentage = (total_pages / max_pages) * 100
		(percentage / 5).ceil * 5 # round up to nearest five
	end

	# Take a guess at how many lines will be used by the given text at the
	# font-size and left/right margins stored in the plan's settings.
	# This assumes a fixed-width for each glyph, which is obviously
	# incorrect for the font-face choices available; the idea is that
	# they'll hopefully average out to that in the long-run.
	def lines_from_text(text)
	  return 0 unless text.present?

	  @formatting ||= self.settings(:export).formatting

	  margin_width = @formatting[:margin][:left].to_i + @formatting[:margin][:right].to_i
	  chars_in_line = 91 # @formatting[:font_size] (12)

	  (text.length / chars_in_line.to_f).ceil
	end

end
