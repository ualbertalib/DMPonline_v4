$( document ).ready(function() {
	
	$('abbr.timeago').timeago();
	
	$("form.answer").submit(function(){
		q_status = $(this).children(".answer-status:first");
		timeout = setTimeout(function(){
			$.getJSON("status.json", function(data) {
				$("#questions-progress").css("width", (data.num_answers/data.num_questions*100)+"%");
				$("#questions-progress").text(data.num_answers+" of "+data.num_questions+" answered");
				q_status.removeClass("label-info label-warning");
				q_status.addClass("label-success");
				t = q_status.children("abbr:first");
				now = new Date();
				t.text(now);
				t.attr('title', now.toISOString()).data("timeago",null).timeago();
			});
		},500);
	});

});