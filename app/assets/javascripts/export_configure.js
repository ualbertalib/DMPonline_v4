$(document).ready(function() {
  var form,
       btn = $('#export_configure');

  btn.click(function(e) {
    e.preventDefault();

    if (form)
      return form.toggle();

    var container = btn.parent();

    $.get($(this).attr('href') + '.partial')
      .done(function(data) {
        form = $(data)
          btn.parent().find("ul").first().before(form);
      })
      .fail(function(data) {
        // Handle failure?
      });
  });
});
