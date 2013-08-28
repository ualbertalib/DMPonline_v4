$( document ).ready(function() {
	
	$("#parent_id").change(function () {
		update_child_options($("#project_unit_id"), "children", $(this).val(), 1)
	});
	
	$("#Funder").change(function () {
		update_child_options($("#project_dmptemplate_id"), "templates", $(this).val(), 2)
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