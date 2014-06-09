//= require jquery.timeago.js
//= require tinymce

var dirty = {};

$( document ).ready(function() {

	// Make timestamps readable
	$('abbr.timeago').timeago();

	window.onbeforeunload = function(){
		if (is_dirty()) {
			var questions = get_unsaved_questions();
			var message = 'You have unsaved answers in the following sections:\n';
			$.each(questions, function(section_text, question_texts){
				message += "\n\u2022"+section_text;
			});
		  return message;
		}
	};

	// Update status messages on form submission
	$("form.answer").submit(function(){
		var submit_button = $(this).find('input[type="submit"]');
		var saving_message = $(this).find('.saving-message');
		submit_button.parent().hide();
		q_id = $(this).find(".question_id").val();
		saving_message.show();
		s_status = $(this).closest(".accordion-group").find(".section-status:first");
		$.fn.mark_as_clean(s_status.attr("id").split('-')[0], q_id);
		// Allow quarter of a second for database to update
		timeout = setTimeout(function(){
			$.getJSON("status.json", function(data) {
				update_plan_progress(data);
				update_timestamp(q_id, data);
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
	}, 50000);

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
    	update_plan_progress(data);
    	$(".section-status").each(function(){
    		update_section_progress($(this), data);
    	});
    	//For each question in section, check answer timestamp against currently displayed
    	var section_id = section.attr("id").split('-')[1];
    	var num_questions = data.sections[section_id]["questions"].length;
    	for (var i = 0; i < num_questions; i++) {
    		question_id = data.sections[section_id]["questions"][i];
    		//If timestamp newer than displayed, update answers
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
			$.post('unlock_section', {section_id: section_id});
			if (is_dirty(section_id)) {
				$('#unsaved-answers-'+section_id).text("");
				$.each(get_unsaved_questions(section_id), function(index, question_text){
					$('#unsaved-answers-'+section_id).append("<li>"+question_text+"</li>");
				});
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
		$.fn.mark_as_dirty($(this).closest(".accordion-group").find(".section-status:first").attr("id").split('-')[0], $(this).closest("form").find(".question_id").val());
  });

  $(":radio").click(function() {
  	$.fn.mark_as_dirty($(this).closest(".accordion-group").find(".section-status:first").attr("id").split('-')[0], $(this).closest("form").find(".question_id").val());
  });

  $(":checkbox").click(function() {
  	$.fn.mark_as_dirty($(this).closest(".accordion-group").find(".section-status:first").attr("id").split('-')[0], $(this).closest("form").find(".question_id").val());
  });

	$("input").change(function() {
		$.fn.mark_as_dirty($(this).closest(".accordion-group").find(".section-status:first").attr("id").split('-')[0], $(this).closest("form").find(".question_id").val());
	});

	function get_unsaved_questions(section_id) {
		if (section_id != null) {
			var questions = new Array();
			$.each(dirty[section_id], function(question_id,value){
				if (value) {
					questions.push($("label[for='answer-text-"+question_id+"']").text());
				}
			});
			return questions;
		}
		else {
			var questions = {};
			$.each(dirty, function(section_id,question_ids){
				var section_text = $("#section-header-"+section_id).clone().children().remove().end().text().trim();
				questions[section_text] = new Array();
				$.each(question_ids, function(question_id,value){
					if (value) {
						questions[section_text].push($("label[for='answer-text-"+question_id+"']").text());
					}
				});
			});
			return questions;
		}
	}

	function is_dirty(section_id, question_id) {
		if (section_id != null) {
			if (dirty[section_id] != null) {
				if (question_id != null) {
					if (dirty[section_id][question_id] != null) {
						return dirty[section_id][question_id];
					}
					else {
						return false;
					}
				}
				else {
					var is_dirty = false;
					$.each(dirty[section_id], function(question_id, value){
						if (value) {
							is_dirty = true;
						}
					});
					return is_dirty;
				}
			}
		}
		else {
			var is_dirty = false;
			$.each(dirty, function(section_id, questions){
				$.each(questions, function(question_id, value){
					if (value) {
						is_dirty = true;
					}
				});
			});
			return is_dirty;
		}
		return false;
	}

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
					//Update answer options - both in form and readonly
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
					$.fn.mark_as_clean(form_div.closest(".accordion-group").find(".section-status:first").attr("id").split('-')[0], question_id);
				}
			}
		});
  }

	function update_section_progress(section_status, data) {
		s_id = section_status.attr("id").split('-')[0];
		s_qs = data.sections[s_id]["num_questions"];
		question_word = "questions"
		if (s_qs == 1) {
			question_word = "question";
		}
		s_as = data.sections[s_id]["num_answers"];
		section_status.text("("+s_qs+" "+question_word+", "+s_as+" answered)");
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

});

$.fn.mark_as_dirty = function(section_id, question_id) {
	if (dirty[section_id] == null) {
		dirty[section_id] = {};
	}
	dirty[section_id][question_id] = true;
	$("#"+question_id+"-unsaved").show();
};

$.fn.mark_as_clean = function(section_id, question_id) {
	if (dirty[section_id] == null) {
		dirty[section_id] = {};
	}
	dirty[section_id][question_id] = false;
	$("#"+question_id+"-unsaved").hide();
};

$.fn.check_textarea = function(editor) {
	if (editor.isDirty()) {
		$.fn.mark_as_dirty($("#"+editor.id).closest(".accordion-group").find(".section-status:first").attr("id").split('-')[0],editor.id.split('-')[2]);
	}
	else {
		$.fn.mark_as_clean($("#"+editor.id).closest(".accordion-group").find(".section-status:first").attr("id").split('-')[0],editor.id.split('-')[2]);
	}
};
