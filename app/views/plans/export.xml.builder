xml.instruct!
xml.plan("id" => @plan.id) do
	xml.project(@plan.project.title, "id" => @plan.project.id)
	xml.phase(@plan.version.phase.title, "id" => @plan.version.phase.id)
	xml.sections do
		sections = @plan.sections.sort_by(&:"number")
		sections.each do |section|
			xml.section("id" => section.id, "number" => section.number, "title" => section.title) do
				xml.answers do
					questions = section.questions.sort_by(&:"number")
					questions.each do |question|
						xml.question("id" => question.id, "number" => question.number, "multiple_choice" => question.multiple_choice) do
							xml.question_text question.text
							answer = @plan.answer(question.id, false)
							if ! answer.nil? then
								xml.answer("id" => answer.id) do #should add user and date info here
									if question.multiple_choice then
										xml.selections do
											answer.options.each do |option|
												xml.selection(option.text, "id" => option.id, "number" => option.number)
											end
										end
									end
									xml.answer_text answer.text
								end
							end
						end
					end
				end
			end
		end
	end
end