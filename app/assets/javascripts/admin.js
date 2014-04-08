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
		
	
	
});
