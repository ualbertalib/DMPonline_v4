$(document).ready(function() {
  var form;

  $('#export_configure').click(function(e) {
    e.preventDefault();

    var container = $(this).parent();

    if (form) {
      form.toggle();
    } else {

      $.get($(this).attr('href') + '.partial')
       .done(function(data) {
         form = $(data).appendTo(container);
       })
       .fail(function(data) {
         // Handle failure?
       });
    }
  });
});
