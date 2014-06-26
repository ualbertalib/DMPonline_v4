$(document).ready(function() {

  $('.check_select > legend').append('<input type="checkbox" class="toggle" />');

  $('.check_select').each(function() {
    var container = $(this),
           toggle = container.find('> legend > .toggle'),
           checks = container.find('li input[type=checkbox]'),
          checked = function() { return checks.length == checks.filter(':checked').length; };

    toggle.prop('checked', checked());

    checks.change(function() {
      toggle.prop('checked', checked());
    });

    toggle.change(function() {
      checks.prop('checked', toggle.is(':checked'));
    });

  });

});
