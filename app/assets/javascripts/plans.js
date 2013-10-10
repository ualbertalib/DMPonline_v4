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
		submit_button.parent().hide();
		q_id = $(this).find(".question_id").val();
		$("#saving-"+q_id).show();
		s_status = $(this).closest(".accordion-group").find(".section-status:first");
		// Allow half a second for database to update
		timeout = setTimeout(function(){		
			// Get plan status
			$.getJSON("status.json", function(data) {			
				update_plan_progress(data);
				update_timestamp(q_id, data);
				// Get section status element
				update_section_progress(s_status, data);
				submit_button.parent().show();
				$("#saving-"+q_id).hide();
			});
		},500);
	});
	
	//accordion guidance 
	$('.guidance-accordion-toggle').click(function(e){
		e.stopPropagation();
		var show = true;
		var div_to_toggle = $($(this).attr("href"));
		
		if (div_to_toggle.hasClass('in')) {
			show = false;
		}
		
		if (show) {
			$($(this).attr("href")).toggleClass("in");
			$(this).children(".plus-laranja").removeClass("plus-laranja").addClass("minus-laranja");
			
		}
		else {
			$($(this).attr("href")).toggleClass("in");
			$(this).children(".minus-laranja").removeClass("minus-laranja").addClass("plus-laranja");
		}
		
		e.preventDefault();
	    return false;
	});	
	
	
	
	
	
	
	// Periodically check locks on open section - every 20 seconds
	setInterval(function(){
		// Only lock/unlock if there are forms on the page (not read-only)
		if ($('form').length > 0) {
			section = $('.section-collapse');
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
    }
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
});