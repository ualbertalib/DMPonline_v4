$( document ).ready(function() {

	$("#project_institution_id").change(function (i) {
		update_child_options($("#project_unit_id"), "children", i.val, 1);
		$("#confirm-institution").text($("#project_institution_id :selected").text());
		$("#confirm-unit").text("");
	});
	
	$("#project_funder_id").change(function (f) {
		update_child_options($("#project_dmptemplate_id"), "templates", f.val, 2);
		$("#confirm-funder").text($("#project_funder_id :selected").text());
		$("#confirm-template").text("");
	});
	
	$("#project_dmptemplate_id").change(function (f) {
		$("#confirm-template").text($("#project_dmptemplate_id :selected").text());
	});
	
	$("#project_unit_id").change(function (f) {
		$("#confirm-unit").text($("#project_unit_id :selected").text());
	});
	
	$(":checkbox").change(function(){
		if ($(this).is(":checked")) {
			$("#confirm-guidance").append("<li id='confirm-"+$(this).attr("id")+"'>"+$(this).parent().text()+"</li>");
		}
		else {
			$("#confirm-"+$(this).attr("id")).remove();
		}
	});
	
	$("#project-confirmation-dialog").on("show", function(){
		if ($("#confirm-institution").text() == "") {
			$("#confirm-institution").text("None");
		}
		if ($("#confirm-funder").text() == "") {
			$("#confirm-funder").text("None");
		}
		if ($("#confirm-template").text() == "") {
			$("#confirm-template").closest("div").hide();
		}
		else {
			$("#confirm-template").closest("div").show();
		}
		if ($("#confirm-unit").text() == "") {
			$("#confirm-unit").closest("div").hide();
		}
		else {
			$("#confirm-unit").closest("div").show();
		}
		$('.select2-choice').hide();
	});
	
	$("#new-project-cancelled").click(function (){
		$("#project-confirmation-dialog").modal("hide");
		$('.select2-choice').show();
	});
	
	$("#new-project-confirmed").click(function (){
		$("#new_project").submit();
	});
	
	function update_child_options(select_element, action, parent_id, min_to_display) {
		var options = {};
		if (parent_id.length > 0) {
			$.ajax({
				type: 'GET',
				url: "/organisations/"+parent_id+"/"+action+".json",
				dataType: 'json',
				async: false, //Needs to be synchronous, otherwise end up mixing up answers
				success: function(data) {	
					options = data;
				}
			});
		}
		select_element.find("option:gt(0)").remove();
		var count = 0;
		for (var id in options) {
			select_element.append("<option value='"+id+"'>"+options[id]+"</option>");
			count++;
		}
		if (count >= min_to_display) {
			select_element.closest("div").show()
		}
		else {
			select_element.closest("div").hide()
		}
	}
});