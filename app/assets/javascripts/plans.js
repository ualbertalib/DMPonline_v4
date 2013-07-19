$( document ).ready(function() {
	
	$("form.answer").submit(function(){
		timeout = setTimeout(function(){
			$.getJSON("status.json", function(data) {
				$("#questions-progress").css("width", (data.num_answers/data.num_questions*100)+"%");
				$("#questions-progress").text(data.num_answers+" of "+data.num_questions+" answered");
			});
		},2000);
	});

});