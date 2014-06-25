$(document).ready(function() {

  $('.check_select').each(function() {
    var toggle = $('<input type="checkbox" />').appendTo($(this).find('legend')),
        checks = $(this).find('input[type=checkbox]'),
       checked = checks.length == checks.filter(':checked').length;

    toggle.click(function() {
      checks.prop('checked', toggle.is(':checked'));
    });
  });

});
