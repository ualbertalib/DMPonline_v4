// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require v1.js
//= require select2.min.js


$( document ).ready(function() {

	$(function(){
		$('.dropdown-toggle').dropdown()
	});

	$('.accordion-body').on('show', function() {
		var plus = $(this).parent().find(".icon-plus").removeClass("icon-plus").addClass("icon-minus");
	}).on('hide', function(){
		var minus = $(this).parent().find(".icon-minus").removeClass("icon-minus").addClass("icon-plus");
	});
	
	$('.typeahead').select2({
		width: "element",
		allowClear: true
	});
	
	$(".help").popover();
	
	$('.has-tooltip').tooltip({
    placement: "right",
    trigger: "focus"
	});

});