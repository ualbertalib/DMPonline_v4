$( document ).ready(function() {
	
	$('abbr.timeago').timeago();
	
	$("form.answer").submit(function(){
		
		q_status = $(this).children(".answer-status:first");
		s_status = $(this).parents(".accordion-group").find(".section-status:first");
		
		if (q_status.hasClass("label-warning")) {
			q_status.text("");
			q_status.append("<abbr class='timeago'></abbr>");
		}
		q_status.removeClass("label-info label-warning");
		q_status.addClass("label-success");
		t = q_status.children("abbr:first");
		now = new Date();
		t.text(now);
		t.attr('title', now.toISOString()).data("timeago",null).timeago();
		
		timeout = setTimeout(function(){
			$.getJSON("status.json", function(data) {
				$("#questions-progress").css("width", (data.num_answers/data.num_questions*100)+"%");
				$("#questions-progress").text(data.num_answers+" of "+data.num_questions+" answered");
				section = s_status.attr("id").split('-')[0];
				s_qs = data.sections[section]["num_questions"];
				question_word = "questions"
				if (s_qs == 1) { 
					question_word = "question";
				}
				s_as = data.sections[section]["num_answers"];
				s_status.text(s_qs+" "+question_word+", "+s_as+" answered");
				if (s_qs == s_as) {
					s_status.removeClass("label-warning");
					s_status.addClass("label-info");
				}
			});
		},500);
	});

});