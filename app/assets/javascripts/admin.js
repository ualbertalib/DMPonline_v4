//This file is for all javascript regarding org admin
//= require tinymce

$( document ).ready(function() {

	$('#gg_new_text').tooltip({
	    'placement': 'left'
	});

	if($('.in').length > 0) {
		if ($('.in .current_question').length > 0) {
			$(document.body).animate({
				'scrollTop': $('.in .current_question').offset().top
			}, 1000);
		}
		else {
			$(document.body).animate({
				'scrollTop': $('.in').offset().top
			}, 1000);
		}
	}

	//show or hide divs based on what the user selects from the question format. New question
	$('.ques_format').on("change", function(e) {
		var selected_format = $('#new-select-format').val();

		//text area
		if (selected_format == 1){
			$("#new-options").hide();
			$("#new-default-text-field").hide();
			$("#new-default-text-area").show();
			$("#new-default-value-field").show();
		}
		//text field
		else if (selected_format == 2){
			$("#new-options").hide();
			$("#new-default-text-field").show();
			$("#new-default-value-field").show();
			$("#new-default-text-area").hide();
		}
		//checkbox,radio button, dropdown, multi select
		else if (selected_format == 3 ||selected_format == 4 || selected_format == 5 || selected_format == 6){
			$("#new-options").show();
			$("#new-default-text-field").hide();
			$("#new-default-text-area").hide();
			$("#new-default-value-field").hide();
		}
		delete selected_format;
	}).trigger('change');


	//show or hide divs based on what the user selects from the question format
	$('.ques_format').on("change", function(e) {
		var q_id = $(this).find('.quest_id').val();

		var selected_format = $('#'+ q_id +'-select-format').val();
		//text area
		if (selected_format == 1){
			$("#options-"+ q_id).hide();
			$("#default-text-field-"+ q_id).hide();
			$("#default-text-area-"+ q_id).show();
			$("#default-value-field-"+ q_id).show();
		}
		//text field
		else if (selected_format == 2){
			$("#options-"+ q_id).hide();
			$("#default-text-field-"+ q_id).show();
			$("#default-value-field-"+ q_id).show();
			$("#default-text-area-"+ q_id).hide();
		}
		//checkbox,radio button, dropdown, multi select
		else if (selected_format == 3 ||selected_format == 4 || selected_format == 5 || selected_format == 6){
			$("#options-"+ q_id).show();
			$("#default-text-field-"+ q_id).hide();
			$("#default-text-area-"+ q_id).hide();
			$("#default-value-field-"+ q_id).hide();
		}
		delete selected_format;
		delete q_id;
	}).trigger('change');


	//Code to show/hide divs on new guidance (by themes or by question)
	$('#g_options').on("change", function (){
		var g_t_q = $(this).val();

		e_g_q_f = $("#edit_guid_ques_flag").val();

		if (g_t_q == 1){
			$(".guindace_by_question").hide();
			$(".guindance_by_theme").show();
		}
		else if (g_t_q == 2){
			$(".guindace_by_question").show();
			$(".guindance_by_theme").hide();
			//check if editing
			if( e_g_q_f != 2){
				$('#phases_select').hide();
			 	$('#versions_select').hide();
			 	$('#sections_select').hide();
			 	$('#questions_select').hide();

			}
		}

	}).trigger('change');


	//filter from template to question 5 dropdowns
	 $('#templates_select').change(function() {
	 	$.ajax({
	 		type: 'GET',
 			url: "update_phases",
 			dataType: 'script',
			data: {
 				dmptemplate_id : $('#templates_select').val()
 			}
	 	});
	 	$('#phases_select').show();
	 	$('#versions_select').hide();
	 	$('#sections_select').hide();
	 	$('#questions_select').hide();

	 });
	 $('#phases_select').change(function() {
		 	$.ajax({
		 		type: 'GET',
	 			url: "update_versions",
	 			dataType: 'script',
				data:  {
	 				phase_id : $('#phases_select').val()
	 			}
		 	});
		 	$('#phases_select').show();
		 	$('#versions_select').show();
		 	$('#sections_select').hide();
		 	$('#questions_select').hide();
		 });
	 $('#versions_select').change(function() {
		 $.ajax({
		 		type: 'GET',
	 			url: "update_sections",
	 			dataType: 'script',
				data:  {
	 				version_id : $('#versions_select').val()
	 			}
		 	});
		 	$('#phases_select').show();
		 	$('#versions_select').show();
		 	$('#sections_select').show();
		 	$('#questions_select').hide();
		 });
	 $('#sections_select').change(function() {
		 	$.ajax({
		 		type: 'GET',
	 			url: "update_questions",
	 			dataType: 'script',
				data:  {
	 				section_id : $('#sections_select').val()
	 			}
		 	});
		 	$('#phases_select').show();
		 	$('#versions_select').show();
		 	$('#sections_select').show();
		 	$('#questions_select').show();
		 });


	 //action for show or hide template editing display
	 $('#edit_template_button').click(function(){
		 $('#edit_template_div').show();
		 $('#show_template_div').hide();
	 });


	 //action for show or hide phase display
	 $('#edit_phase_button').click(function(){
		 $('#edit_phase_div').show();
		 $('#show_phase_div').hide();
	 });


	 //action to hide the alert to edit a version
	 $("#edit-version-confirmed").click(function (){
		$("#version_edit_alert").modal("hide");
	 });


	 //action to clone/add a version
	 $("#clone-version-confirmed").click(function (){
		$("#new_project").submit();
	 });

	 //action for show question editing display
	 $('.edit_question_button').click(function(e){
		 var q_id = $(this).prev(".question_id").val();
		 $('#edit_question_div_'+ q_id).show();
		 $('#show_question_div_'+ q_id).hide();
		 e.preventDefault();
	 });


	$(".cancel_edit_question").click(function(e){
		 var q_id = $(this).prev(".question_id").val();
		 $('#edit_question_div_'+ q_id).hide();
		 $('#show_question_div_'+ q_id).show();
		 e.preventDefault();
	 });

	 //action for adding a new question
	 $('#add_question_button').click(function(e){
		 $('#add_question_block_div').show();
		 $('#add_question_button_div').hide();
		 e.preventDefault();
	 });

	 //action for cancelling a new question
	 $('#cancel_add_question').click(function(e){
		 $('#add_question_block_div').hide();
		 $('#add_question_button_div').show();
		 e.preventDefault();
	 });

	 //action for adding a new section
	 $('#add_section_button').click(function(e){
		 $('#add_section_block_div').show();
		 $('#add_section_button_div').hide();
		 e.preventDefault();
	 });


	 //action for cancelling a new section
	 $('#cancel_add_section').click(function(e){
		 $('#add_section_block_div').hide();
		 $('#add_section_button_div').show();
		 e.preventDefault();
	 });

	 //SUGGESTED ANSWERS
	//action for adding a new suggested answer
	 $('.add_suggested_answer_button').click(function(e){
		 var q_id = $(this).prev(".question_id").val();

		 $('#add_suggested_answer_block_'+ q_id).show();
		 $('#add_suggested_answer_button_'+ q_id).hide();
		 e.preventDefault();
	 });

	 //cancelling edit of a suggested answer
	 $(".cancel_edit_suggested_answer").click(function(e){
		 var q_id = $(this).prev(".question_id").val();
		 $('#edit_suggested_answer_div_'+ q_id).hide();
		 $('#show_suggested_answer_div_'+ q_id).show();
		 e.preventDefault();
	 });

	 //edit a suggested answer
	 $('.edit_form_for_suggested_answer').click(function(e){
		 var q_id = $(this).prev(".question_id").val();
		 $('#edit_suggested_answer_div_'+ q_id).show();
		 $('#show_suggested_answer_div_'+ q_id).hide();
		 e.preventDefault();
	 });
});


//remove option when question format is base on a choice
function remove_object(link){
	$(link).prev("input[type=hidden]").val("1");
	$(link).closest(".options_content").hide();

}


function add_object(link, association, content) {
	  var new_id = new Date().getTime();
	  var regexp = new RegExp("new_" + association, "g")
	  if (association == 'options') {
		  $(link).parent().children('.options_table').children('.options_tbody').children('.new_option_before').before(content.replace(regexp, new_id));
	  }
}
