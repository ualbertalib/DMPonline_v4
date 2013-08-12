$( document ).ready(function() {

	$.post('delete_recent_locks');
	
	$('abbr.timeago').timeago();
	
	$("form.answer").submit(function(){
		
		q_status = $(this).children(".answer-status:first");
		s_status = $(this).parents(".accordion-group").find(".section-status:first");
		
		timeout = setTimeout(function(){
			$.getJSON("status.json", function(data) {
				
				$("#questions-progress").css("width", (data.num_answers/data.num_questions*100)+"%");
				$("#questions-progress").text(data.num_answers+"/"+data.num_questions+" answered");
				
				t = q_status.children("abbr:first");
				q_id = q_status.attr("id").split('-')[0];
				timestamp = new Date(Number(data.questions[q_id]["answer_created_at"]) * 1000);
				if (timestamp.toISOString() != t.attr('title')) {
					if (q_status.hasClass("label-warning")) {
						q_status.text("");
						q_status.append("<abbr class='timeago'></abbr>");
					}
					q_status.removeClass("label-info label-warning");
					q_status.addClass("label-success");
					t = q_status.children("abbr:first");
					t.text(timestamp.toUTCString());
					t.attr('title', timestamp.toISOString()).data("timeago",null).timeago();
				}
		
				s_id = s_status.attr("id").split('-')[0];
				s_qs = data.sections[s_id]["num_questions"];
				question_word = "questions"
				if (s_qs == 1) { 
					question_word = "question";
				}
				s_as = data.sections[s_id]["num_answers"];
				s_status.text(s_qs+" "+question_word+", "+s_as+" answered");
				if (s_qs == s_as) {
					s_status.removeClass("label-warning");
					s_status.addClass("label-info");
				}
			});
		},500);
	});
	
	setInterval(function(){
		if ($('form').length > 0) {
			var t = $('.accordion-body.in.collapse');
			var section_id = t.attr("id").split('-')[1];
			$.getJSON("locked.json?section_id="+section_id, function(data) {
				if (data.locked == true && data.current_user == false) {
					t.find("input").attr('disabled', 'disabled');
					t.find(".question-form").hide();
					t.find("select").attr('disabled', 'disabled');
					t.find(".question-readonly").show();
				}    		
				else {
					$.post('lock_section', {section_id: section_id} );
					t.find("input").removeAttr('disabled');
					t.find("question-form").show();
					t.find("select").removeAttr('disabled');
					t.find(".question-readonly").hide();
				}
			});
    }
	}, 20000);
	
	
	$('.collapse').on('show', function() {
		if ($('form').length > 0) {
			var t = $(this);
			var section_id = t.attr("id").split('-')[1];
			if ($('form').length > 0) {
				//update answers - display text
				$.getJSON("locked.json?section_id="+section_id, function(data) {
					if (data.locked == true && data.current_user == false) {
						t.find("input").attr('disabled', 'disabled');
						t.find(".question-form").hide();
						t.find("select").attr('disabled', 'disabled');
						t.find(".question-readonly").show();
					}    		
					else {
						$.post('lock_section', {section_id: section_id} );
						t.find("input").removeAttr('disabled');
						t.find("question-form").show();
						t.find("select").removeAttr('disabled');
						t.find(".question-readonly").hide();
					}
				});
			}
    }
    var header = $("a[href='#" + t.attr("id") + "']");
    header.find(".icon-plus").removeClass("icon-plus").addClass("icon-minus");
  }).on('hide', function(){
  	if ($('form').length > 0) {
			var t = $(this);
			var section_id = t.attr("id").split('-')[1];
			$.post('unlock_section', {section_id: section_id} );
    }
    var header = $("a[href='#" + t.attr("id") + "']");
    header.find(".icon-minus").removeClass("icon-minus").addClass("icon-plus");
  });
});