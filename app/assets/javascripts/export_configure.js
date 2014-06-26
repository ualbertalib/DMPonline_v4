$(document).ready(function() {

  $('.check_select > legend').append('<input type="checkbox" class="toggle" />');

  $('.check_select').each(function() {
    var container = $(this),
           toggle = container.find('> legend > .toggle'),
           checks = container.find('li input[type=checkbox]'),
          checked = function() {
            var checked = checks.filter(':checked');

            if (checks.length == checked.length)
              return {'checked': true};

            if (checked.length == 0)
              return {'checked': false};

            return {'indeterminate': true}
          };

    toggle.prop(checked());

    checks.change(function() {
      toggle.prop('indeterminate', false);
      toggle.prop(checked());
    });

    toggle.change(function() {
      toggle.prop('indeterminate', false);
      checks.prop('checked', toggle.is(':checked'));
      toggle.prop(checked());
    });

  });

});
