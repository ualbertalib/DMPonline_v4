//This file is for all javascript regarding org admin
//= require tinymce

$( document ).ready(function() {
	
	//Guidance group add for in org Admin area
	$('#add_guidance_group_form_div').hide();
	
	$('#add_guidance_group_button').click(function(e) {
		 e.preventDefault();
		$('#add_guidance_group_form_div').show();//Form shows on button click
		$('#add_guidance_group_button_div').hide();
	});
	
	$('#show_add_guidance_group_button').click(function(e) {
		e.preventDefault();
		$('#add_guidance_group_button_div').show();//Form shows on button click
		$('#add_guidance_group_form_div').hide();
	});
	
	
	//show or hide divs based on what the user selects from the question format
	$('.ques_format').on("change", function(e) {
		q_id = $(this).find(".question_id").val();
		
		var selected_format = $('#' + q_id + '-select-format').val();
		
		//text area
		if (selected_format == 1){
			$("#options-" + q_id).hide();
			$("#default-text-field-" + q_id).hide();
			$("#default-text-area-" + q_id).show();
		}
		//text field
		else if (selected_format == 2){
			$("#options-" + q_id).hide();
			$("#default-text-field-" + q_id).show();
			$("#default-text-area-" + q_id).hide();
		}
		//checkbox,radio button, dropdown, multi select
		else if (selected_format == 3 ||selected_format == 4 || selected_format == 5 || selected_format == 6){
			$("#options-" + q_id).show();
			$("#default-text-field-" + q_id).hide();
			$("#default-text-area-" + q_id).hide();
		}
		delete selected_format; 
	}).trigger('change');
	
});

//remove option when question format is base on a choice
function remove_option(link){
	$(link).prev("input[type=hidden]").val("1");
	$(link).closest(".options_content").hide();

}

function add_options(link, association, content) {
	  var new_id = new Date().getTime();
	  var regexp = new RegExp("new_" + association, "g")
	  $(link).parent().children(".options_table").children(".options_tbody").after(content.replace(regexp, new_id));
}