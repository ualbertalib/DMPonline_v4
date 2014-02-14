//= require jquery.timeago.js
//= require tinymce

$( document ).ready(function() {
	
	// Delete 30min locks set in case user doesn't have JS
	$.post('delete_recent_locks');
	
	// Make timestamps readable
	$('abbr.timeago').timeago();
	
	// Update status messages on form submission
	$("form.answer").submit(function(){
		var submit_button = $(this).find('input[type="submit"]');
		var saving_message = $(this).find('.saving-message');
		submit_button.parent().hide();
		q_id = $(this).find(".question_id").val();
		saving_message.show();
		s_status = $(this).closest(".accordion-group").find(".section-status:first");
		// Allow quarter of a second for database to update
		timeout = setTimeout(function(){		
			// Get plan status
			$.getJSON("status.json", function(data) {			
				update_plan_progress(data);
				update_timestamp(q_id, data);
				// Get section status element
				update_section_progress(s_status, data);
				submit_button.parent().show();
				saving_message.hide();
			});
		},250);
	});

	
	//accordion guidance 
	$('.accordion-guidance-link').on('click', function (e) {
		e.stopPropagation();
		var show = true;
		var div_to_toggle = $($(this).attr("href"));
		if (div_to_toggle.hasClass('in')) {
			show = false;
		}
		$($(this).attr("href")).toggleClass("in");
		if (show) {
			$(this).children(".plus-laranja").removeClass("plus-laranja").addClass("minus-laranja");
		}
		else {
			$(this).children(".minus-laranja").removeClass("minus-laranja").addClass("plus-laranja");
		}
		delete show;
		delete div_to_toggle;
		e.preventDefault();
	  //return false;
	});
	
	
	// Periodically check locks on open section - every 20 seconds
	setInterval(function(){
		// Only lock/unlock if there are forms on the page (not read-only)
		if ($('form').length > 0) {
			section = $('.section-collapse.in');
			if (section.length > 0) {
				check_section_lock(section);
			}
    }
	}, 20000);
	
	// Handle section actions on accordion expansion/collapse
	$('.section-collapse').on('show', function() {
		var section = $(this);
		section.find(".loaded").hide();
		section.find(".loading").show();
		// Only lock if there are forms on the page (not read-only)
		if ($('form').length > 0) {
			check_section_lock(section);
    }
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
    	section.find("select").change();
    	section.find(":radio").each(function(){
    		update_answer($(this).closest("form").find(".question_id").val()); //hack to cope with previous radio button selections not appearing
    	});
    	section.find(":radio:checked").click();
	    $(":checkbox:checked").each( function(){
	    	display_warning($(this).val(), $(this).closest("form").find(".question_id").val(), false);
	    });
    	section.find(".loading").hide();
			section.find(".loaded").show();
    });
   }).on('hide', function(){
  	var section = $(this);
  	// Only attempt unlock if there are forms on the page (not read-only)
  	if ($('form').length > 0) {
			var section_id = section.attr("id").split('-')[1];
			$.post('unlock_section', {section_id: section_id} );
			var updated_questions = [];
			$.ajax({
				type: 'GET',
				url: "section_answers.json?section_id="+section_id,
				dataType: 'json',
				async: false,
				success: function(data) {
					var num_questions = data.length;
					for (var i = 0; i < num_questions; i++) {
						var entered_text_to_compare = null;
						var stored_text_to_compare = null;
						
						if ($('input#answer-text-'+data[i].id).length == 1) {
							entered_text_to_compare = $('input#answer-text-'+data[i].id).val();
							stored_text_to_compare = (data[i].answer_text);
						}
						else{
							entered_text_to_compare = strip_tags_and_whitespace(tinymce.get('answer-text-'+data[i].id).getContent());
							stored_text_to_compare = strip_tags_and_whitespace(data[i].answer_text);
						}
						
						if(entered_text_to_compare != stored_text_to_compare) {
							updated_questions.push(data[0].id);
						}
						//Needs to work for multiple choice too
					}
				}
			});
			if (updated_questions.length > 0) {
				if (updated_questions.length == 1) {
					$('#section-' + section_id + '-collapse-alert-singular').show();
					$('#section-' + section_id + '-collapse-alert-plural').hide();
				}
				else {
					$('#section-' + section_id + '-collapse-alert-count').text(updated_questions.length);
					$('#section-' + section_id + '-collapse-alert-singular').hide();
					$('#section-' + section_id + '-collapse-alert-plural').show();
				}
				$('#section-' + section_id + '-collapse-alert').modal();
			}
    }
  });
  
  $(".cancel-section-collapse").click(function () {
  	var section_id = $(this).attr('data-section');
  	$("#collapse-" + section_id).collapse("show");
  	$('#section-' + section_id + '-collapse-alert').modal("hide");
  });
  
  $(".discard-section-collapse").click(function () {
  	var section_id = $(this).attr('data-section');
  	$('#section-' + section_id + '-collapse-alert').modal("hide");
  });
  
  $(".save-section-collapse").click(function () {
  	var section_id = $(this).attr('data-section');
  	$("#collapse-" + section_id).find("input[type='submit']").click();
  	$('#section-' + section_id + '-collapse-alert').modal("hide");
  });
  
  $("select").change(function() {
  	display_warning($(this).val(), $(this).closest("form").find(".question_id").val(), true);
  });
  
  $(":radio").click(function() {
  	display_warning($(this).val(), $(this).closest("form").find(".question_id").val(), true);
  });
  
  $(":checkbox").click(function() {
  	if ($(this).is(":checked")) {
  		display_warning($(this).val(), $(this).closest("form").find(".question_id").val(), false);
  	}
  	else {
  		clear_warning($(this).val());
  	}
  });
  
  function update_answer(question_id) {
  	$.ajax({
			type: 'GET',
			url: "answer.json?q_id="+question_id,
			dataType: 'json',
			async: false, //Needs to be synchronous, otherwise end up mixing up answers
			success: function(data) {
				if (data != null) {
					//Get divs containing the form and readonly versions
					var form_div = $("#question-form-"+question_id);
					var readonly_div = $("#question-readonly-"+question_id);
					//Look for textfields
					if ($("input#answer-text-"+question_id).length == 1) {
						$("input#answer-text-"+question_id).val(data.text);
						readonly_div.find('.answer-text-readonly').html("<p>"+data.text+"</p>");
					}
					else {
						//Update answer text - both in textarea and readonly
						$('#answer-text-'+question_id).val(data.text);
						tinymce.get('answer-text-'+question_id).setContent(data.text);
						readonly_div.find('.answer-text-readonly').html(data.text);	
					}
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
		section_status.text("("+s_qs+" "+question_word+", "+s_as+" answered)");
		// Change class of section status - currently has no effect on appearance
		if (s_qs == s_as) {
			section_status.removeClass("label-warning");
			section_status.addClass("label-info");
		}
	}
	
	function update_plan_progress(data) {
		if (data.num_answers > 0) {
			$(".progress").children(".color-text").remove();
			$("#questions-progress").show();
			$("#questions-progress").css("width", (data.num_answers/data.num_questions*100)+"%");
			$("#questions-progress").text(data.num_answers+"/"+data.num_questions);
		}
		else {
			$("#questions-progress").hide();
		}
	}
	
	function update_timestamp(question_id, data) {
		q_status = $('#'+question_id+'-status');
		var t = q_status.children("abbr:first");
		var current_timestamp = new Date(t.attr('data-time'));
		var timestamp = data.questions[question_id]["answer_created_at"];
		if (timestamp != null) {
			timestamp = new Date(Number(timestamp) * 1000);
			if (timestamp.getTime() != current_timestamp.getTime()) {
				q_status.text("");
				q_status.append("Answered <abbr class='timeago'></abbr> by "+data.questions[question_id]["answered_by"]);
				t = q_status.children("abbr:first");
				// Update label to indicate successful submission
				q_status.removeClass("label-info label-warning");
				q_status.addClass("label-success");
				// Set timestamp text and data
				t.text(timestamp.toUTCString());
				t.attr('title', timestamp.toISOString()).data("timeago",null).timeago();
				t.attr('data-time', timestamp.toISOString());
				return true;
			}
		}
		return false;
	}
	
	// Checks section locks, applies lock if needed. Does not lift lock.
	// If locked, display questions as read-only. Otherwise, apply lock and display as editable.
	function check_section_lock(section) {
		var section_id = section.attr("id").split('-')[1];
		$.getJSON("locked.json?section_id="+section_id, function(data) {
			if (data.locked) {
				section.find(".section-lock-notice").html("<p>This section is locked for editing by " + data.locked_by + ".</p>");
				section.find(".section-lock-notice").show();
				section.find("input").attr('disabled', 'disabled');
				section.find(".question-form").hide();
				section.find("select").attr('disabled', 'disabled');
				section.find(".question-readonly").show();
			}    		
			else {
				$.post('lock_section', {section_id: section_id} );
				section.find(".section-lock-notice").html("");
				section.find(".section-lock-notice").hide();
				section.find("input").removeAttr('disabled');
				section.find(".question-form").show();
				section.find("select").removeAttr('disabled');
				section.find(".question-readonly").hide();
			}
		});
		return true;
	}
	
	function display_warning(option_id, question_id, hide){
		if (hide) {
			$("#option-warning-"+question_id+" > p").hide();
			$("#option-warning-"+question_id).hide();
		}
		if ($.isArray(option_id)) {
			$.each(option_id, function () {
				display_warning(this, question_id, false);
			});
		}
		else {
			$("#"+option_id+"-warning").show();
			$("#option-warning-"+question_id).show();
		}
	}
	
	function clear_warning(option_id, question_id){
		$("#"+option_id+"-warning").hide();
		$("#option-warning-"+question_id).not(":has(p)").hide();
	}
	
	function strip_tags_and_whitespace(html) {
		var div = document.createElement("div");
		div.innerHTML = html;
		var text = div.textContent || div.innerText || "";
		text = text.replace(/\s+/g,"");
		text = text.replace(/(\r\n|\n|\r)/gm,"");
		return text;
	}
	
	
});