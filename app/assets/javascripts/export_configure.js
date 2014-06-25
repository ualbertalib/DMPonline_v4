$(document).ready(function() {

  $('.check_select').each(function() {
    var toggle = $('<input type="checkbox" />').appendTo($(this).find('legend')),
        checks = $(this).find('li input[type=checkbox]'),
       checked = checks.length == checks.filter(':checked').length;

    toggle.prop('checked', checked);

    toggle.click(function() {
      checks.prop('checked', toggle.is(':checked'));
    });
  });

});
