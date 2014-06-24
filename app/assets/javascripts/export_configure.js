$(document).ready(function() {

  var admin_details_all = $('<input type="checkbox" />').appendTo('#admin_details legend'),
           admin_checks = $('#admin_details > input[type=checkbox]'),
            all_checked = admin_checks.length == admin_checks.filter(':checked').length;

  admin_details_all.attr('checked', all_checked);

  admin_details_all.click(function() {
    admin_checks.prop('checked', admin_details_all.is(':checked'));
  })

});
