$( document ).ready(function() {

	$("#sections-accordion").accordion({
		heightStyle: "content",
		collapsible: true
	});

	$.getJSON("status.json", function(data) {
		$("#questions-progress").progressbar({
			max: data.num_questions,
			value: data.num_answers
		});
		$(".progress-label").text(data.num_answers+" of "+data.num_questions+" answered.");
	});

});