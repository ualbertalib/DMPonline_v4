$(document).ready(function() {

  $('.check_select > legend').append('<input type="checkbox" class="toggle" />');

  $('.check_select').each(function() {
    var container = $(this),
           toggle = container.find('> legend > .toggle'),
           checks = container.find('> ol > li > input[type=checkbox], li > fieldset > legend > input[type=checkbox]');


    function checked(toggle) {
      var checks = toggle.prop('checks'),
         checked = checks.filter(':checked').length;

      return {
        'indeterminate' : (checked > 0 && checked < checks.length),
              'checked' : (checked == checks.length)
      };
    }

    function toggleParent(toggle) {
      var parent_toggle = toggle.prop('toggle');

      if (parent_toggle)
        parent_toggle.prop(checked(parent_toggle));
    }

    checks.prop('toggle', toggle);
    toggle.prop('checks', checks);
    toggle.prop('id', container.find('> legend > label').prop('for'));
    toggle.prop(checked(toggle));
    toggleParent(toggle);

    checks.change(function() {
      toggle.prop(checked(toggle));
      toggleParent(toggle);
    });

    toggle.change(function() {
      checks.prop('checked', toggle.is(':checked'));
      toggle.prop(checked(toggle));
    });

  });
});
