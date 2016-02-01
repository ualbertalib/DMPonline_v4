$( document ).ready(function() {
/* remove temporarily as we don't have funder templates 
removed by wshi on Feb 9, 2015
	$("#project_funder_id").change(function () {
		update_template_options();
		update_guidance_options();
		if ($(this).val().length > 0) {
			$("#other-funder-name").hide();
			$("#project_funder_name").val("");
		}
		else {
			$("#other-funder-name").show();
		}
		$("#institution-control-group").show();
		$("#create-plan-button").show();
		$("#confirm-funder").text($("#project_funder_id").select2('data').text);
	});

	$("#no-funder").click(function(e) {
		e.preventDefault();
		$("#project_funder_id").select2("val", "");
		update_template_options();
		update_guidance_options();
		$("#institution-control-group").show();
		$("#create-plan-button").show();
		$("#other-funder-name").show();
		$("#confirm-funder").text(get_locale_string());
	});

	$("#project_funder_name").change(function(){
		$("#confirm-funder").text($(this).val());
	});
*/

	$("#project_institution_id").change(function () {
		update_template_options();
		update_guidance_options();
		$("#confirm-institution").text($("#project_institution_id").select2('data').text);
	});

	$("#no-institution").click(function() {
		$("#project_institution_id").select2("val", "");
		update_template_options();
		update_guidance_options();
		$("#confirm-institution").text(get_locale_string());
	});

	$("#project_dmptemplate_id").change(function (f) {
		update_guidance_options();
		$("#confirm-template").text($("#project_dmptemplate_id :selected").text());
	});

        
        $("#create-plan-button").click(function() {
                if ($("#confirm-template").text() == "") {
                	update_template_options();
                	update_guidance_options();
                }
        });

	$("#project-confirmation-dialog").on("show", function(){
		if ($("#confirm-institution").text() == "") {
			$("#confirm-institution").text(get_locale_string());
		}
		if ($("#confirm-funder").text() == "") {
			$("#confirm-funder").text(get_locale_string());
		}
		if ($("#confirm-template").text() == "") {
			$("#confirm-template").closest("div").hide();
		}
		else {
			$("#confirm-template").closest("div").show();
		}
		$("#confirm-guidance").empty();
		$("input:checked").each(function(){
			$("#confirm-guidance").append("<li id='confirm-"+$(this).attr("id")+"'>"+$(this).parent().text()+"</li>");
		});
		$('.select2-choice').hide();
	});

	$("#new-project-cancelled").click(function (){
		$("#project-confirmation-dialog").modal("hide");
		$('.select2-choice').show();
	});

	$("#new-project-confirmed").click(function (){
		$("#new_project").submit();
	});

    //for the default template alert
	$("#default-template-confirmation-dialog").on("show", function(){
		$('.select2-choice').hide();
	});

	$("#default-template-cancelled").click(function (){
		$("#default-template-confirmation-dialog").modal("hide");
		$('.select2-choice').show();
	});

	$("#default-template-confirmed").click(function (){
		$("#default_tag").val('true');
		$("#new_project").submit();
	});


	function update_template_options() {
		var options = {};
		var funder = $("#project_funder_id").select2('val');
		var institution = $("#project_institution_id").select2('val');
                if (institution == "") {
                  institution = '8';
                }
		$.ajax({
			type: 'GET',
                        url: "possible_templates.json?institution="+institution,
/* temporarily change the url to disable funder dropdown menu
			url: "possible_templates.json?institution="+institution+"&funder="+funder,
*/
			dataType: 'json',
			async: false, //Needs to be synchronous, otherwise end up mixing up answers
			success: function(data) {
				options = data;
			}
		});
		select_element = $("#project_dmptemplate_id");
		select_element.find("option").remove();
                var options_length = options.length;
		for (var i = 0; i < options_length; i++) {
                        t = options[i]
			if (i == 0) {
				select_element.append("<option value='"+t["id"]+"' selected='selected'>"+t["title"]+"</option>");
			}
			else {
				select_element.append("<option value='"+t["id"]+"'>"+t["title"]+"</option>");
			}
		}
               	if (options_length > 0) {
			$("#template-control-group").show();
		}
		else {
			$("#template-control-group").hide();
		}
		$("#confirm-template").text("");
		$("#project_dmptemplate_id").change();
	}

	function update_guidance_options() {
		var institution = $("#project_institution_id").select2('val');
		var template = $("#project_dmptemplate_id :selected").val();
		$.ajax({
			type: 'GET',
			url: "possible_guidance.json?institution="+institution+"&template="+template,
			dataType: 'json',
			async: false, //Needs to be synchronous, otherwise end up mixing up answers
			success: function(data) {
				options = data;
			}
		});
		options_container = $("#guidance-control-group");
		options_container = options_container.find(".choices-group");
		options_container.empty();
		var count = 0;
		for (var id in options) {
			options_container.append("<li class='choice'><label for='project_guidance_group_ids_"+id+"'><input id='project_guidance_group_ids_"+id+"' name='project[guidance_group_ids][]' type='checkbox' value='"+id+"' />"+options[id]+"</label></li>");
			count++;
		}
		if (count > 0) {
			$("#guidance-control-group").show();
		}
		else {
			$("#guidance-control-group").hide();
		}
	}
        function get_locale_string() {
                  var current_path = window.location.pathname;
                  var current_locale = current_path.split("/")[1];
                  var none;
                  if(current_locale == "fr"){
                       none = "Aucun";}
                  else{
                       none = "None";}
                  return none;

        }
});

