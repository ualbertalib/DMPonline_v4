$( document ).ready(function() {
	
	// Delete 30min locks set in case user doesn't have JS
	$.post('delete_recent_locks');
	
	// Make timestamps readable
	$('abbr.timeago').timeago();
	
	// Update status messages on form submission
	$("form.answer").submit(function(){
		q_id = $(this).find(".question_id").val();
		// Allow half a second for database to update
		timeout = setTimeout(function(){		
			// Get plan status
			$.getJSON("status.json", function(data) {			
				update_plan_progress(data);
				update_timestamp(q_id, data);
				// Get section status element
				s_status = $(this).parents(".accordion-group").find(".section-status:first");
				update_section_progress(s_status, data)
			});
		},500);
	});
	
	// Periodically check locks on open section - every 20 seconds
	setInterval(function(){
		// Only lock/unlock if there are forms on the page (not read-only)
		if ($('form').length > 0) {
			section = $('.accordion-body.in.collapse');
			if (section.length > 0) {
				check_section_lock(section);
			}
    }
	}, 20000);
	
	// Handle section actions on accordion expansion/collapse
	$('.collapse').on('show', function() {
		var section = $(this);
		section.find(".loaded").hide();
		section.find(".loading").show();
		// Only lock if there are forms on the page (not read-only)
		if ($('form').length > 0) {
			check_section_lock(section);
    }
    // Toggle +/- in section header
    var header = $("a[href='#" + section.attr("id") + "']");
    header.find(".icon-plus").removeClass("icon-plus").addClass("icon-minus");
    // check for updated answers
    $.getJSON("status.json", function(data) {
    	//Update overall progress
    	update_plan_progress(data);
    	//Update section progress for all sections
    	$(".section-status").each(function(){
    		update_section_progress($(this), data);
    	});
    	// - for each question in section, check answer timestamp against currently displayed
    	var section_id = section.attr("id").split('-')[1];
    	var num_questions = data.sections[section_id]["questions"].length;
    	for (var i = 0; i < num_questions; i++) {
    		question_id = data.sections[section_id]["questions"][i];
    		// - if timestamp newer than displayed, update answers
    		if (update_timestamp(question_id, data)) {
    			update_answer(question_id);
    		}
    	}
    	section.find(".loading").hide();
			section.find(".loaded").show();
    });
   }).on('hide', function(){
  	var section = $(this);
  	// Only attempt unlock if there are forms on the page (not read-only)
  	if ($('form').length > 0) {
			var section_id = section.attr("id").split('-')[1];
			$.post('unlock_section', {section_id: section_id} );
    }
    // Toggle +/- in section header
    var header = $("a[href='#" + section.attr("id") + "']");
    header.find(".icon-minus").removeClass("icon-minus").addClass("icon-plus");
  });
  
  function update_answer(question_id) {
  	$.ajax({
			type: 'GET',
			url: "answer.json?q_id="+question_id,
			dataType: 'json',
			async: false, //Needs to be synchronous, otherwise end up mixing up answers
			success: function(data) {	
				//Get divs containing the form and readonly versions
				var form_div = $("#question-form-"+question_id);
				var readonly_div = $("#question-readonly-"+question_id);
				//Update answer text - both in textarea and readonly
				$('#answer-text-'+question_id).val(data.text);
				tinymce.get('answer-text-'+question_id).setContent(data.text);
				readonly_div.find('.answer-text-readonly').html(data.text);
				//Update answer options - both in textarea and readonly
				num_options = data.options.length;
				form_div.find('option').each(function(){
					var selected = false;
					for (var j =0; j < num_options; j++) {
						if ($(this).val() == data.options[j].id) {
							selected = true;
						}
					}
					if (selected) {
						$(this).attr('selected', 'selected');
					}
					else {
						$(this).removeAttr('selected');
					}
				});
				form_div.find(':checkbox,:radio').each(function(){
					var selected = false;
					for (var j =0; j < num_options; j++) {
						if ($(this).val() == data.options[j].id) {
							selected = true;
						}
					}
					if (selected) {
						$(this).attr('checked', 'checked');
					}
					else {
						$(this).removeAttr('checked');
					}
				});
		
				var list_string = "";
				for (var j =0; j < num_options; j++) {
					list_string += "<li>"+data.options[j].text+"</li>";
				}
				readonly_div.find('.options').html(list_string);
			}
		});
  }
  	
	function update_section_progress(section_status, data) {
		// Get section ID
		s_id = section_status.attr("id").split('-')[0];
		// Get number of questions in section
		s_qs = data.sections[s_id]["num_questions"];
		question_word = "questions"
		if (s_qs == 1) { 
			question_word = "question";
		}
		// Get number of answers in section
		s_as = data.sections[s_id]["num_answers"];
		// Update section status text
		section_status.text(s_qs+" "+question_word+", "+s_as+" answered");
		// Change class of section status - currently has no effect on appearance
		if (s_qs == s_as) {
			section_status.removeClass("label-warning");
			section_status.addClass("label-info");
		}
	}
	
	function update_plan_progress(data) {
		$("#questions-progress").css("width", (data.num_answers/data.num_questions*100)+"%");
		$("#questions-progress").text(data.num_answers+"/"+data.num_questions);
	}
	
	function update_timestamp(question_id, data) {
		q_status = $('#'+question_id+'-status');
		var t = q_status.children("abbr:first");
		var current_timestamp = new Date(t.attr('data-time'));
		var timestamp = new Date(Number(data.questions[question_id]["answer_created_at"]) * 1000);
		if (timestamp.getTime() != current_timestamp.getTime()) {
			// If question has not been answered previously, need to add abbr for timestamp
			if (q_status.hasClass("label-warning")) {
				q_status.text("");
				q_status.append("<abbr class='timeago'></abbr>");
				t = q_status.children("abbr:first");
			}
			// Update label to indicate successful submission
			q_status.removeClass("label-info label-warning");
			q_status.addClass("label-success");
			// Set timestamp text and data
			t.text(timestamp.toUTCString());
			t.attr('title', timestamp.toISOString()).data("timeago",null).timeago();
			t.attr('data-time', timestamp.toISOString());
			return true;
		}
		return false;
	}
	
	// Checks section locks, applies lock if needed. Does not lift lock.
	// If locked, display questions as read-only. Otherwise, apply lock and display as editable.
	function check_section_lock(section) {
		var section_id = section.attr("id").split('-')[1];
		$.getJSON("locked.json?section_id="+section_id, function(data) {
			if (data.locked == true && data.current_user == false) {
				section.find("input").attr('disabled', 'disabled');
				section.find(".question-form").hide();
				section.find("select").attr('disabled', 'disabled');
				section.find(".question-readonly").show();
			}    		
			else {
				$.post('lock_section', {section_id: section_id} );
				section.find("input").removeAttr('disabled');
				section.find("question-form").show();
				section.find("select").removeAttr('disabled');
				section.find(".question-readonly").hide();
			}
		});
		return true;
	} 
});