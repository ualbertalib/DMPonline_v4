$(document).ready(function() {

  var toolbar = $('.dmp_toolbar').first(),
         form = null;

  $('#toolbar_configure').click(function(e) {
    e.preventDefault();

    if (form) {
      form.toggle();
    } else {
      $.get('/settings/projects.json')
       .done(buildSettingsForm)
       .fail(function(data) {
         // Handle failure?
       });
    }
  });

  // FIXME: it would be simpler just to return the partial from
  // Settings::ProjectsController#show, but that would perhaps
  // mean responding to a JSON request with HTML.
  function buildSettingsForm(data) {
    if (!form)
      form = $('<form method="POST" action="/settings/projects"></form>');

    var table = $('<table class="dmp_table"></table>').appendTo(form),
        thead = $('<thead><tr></tr></thead>').appendTo(table),
        tbody = $('<tbody><tr></tr></tbody>').appendTo(table),
        tfoot = $('<tfoot><tr></tr></tfoot>').appendTo(table),
         cols = data.all_columns,
     selected = data.selected_columns;

    table.before('<input name="_method" type="hidden" value="put" />'); // PUT not POST
    table.before('<input name="authenticity_token" type="hidden" value="' + $('meta[name="csrf-token"]').attr('content') + '" />'); // Auth token

    // Default name column
    table.before('<input type="hidden" name="columns[name]" value="1" />');
    thead.append('<th><label for="columns_name">Name</label></th>');
    tbody.append('<td><input type="checkbox" id="columns_name" name="columns[name]" value="1" checked disabled /></td>')

    for (var i = 0, len = cols.length; i < len; i++) {
      var title = cols[i].replace(/^\w|_/g, function(c) { return c === '_' ? ' ' : c.toUpperCase(); }), // FIXME: add titles to response for I18n?
          label = $('<th><label for="columns_' + cols[i] + '">' + title + '</label></th>').appendTo(thead),
      container = $('<td></td>').appendTo(tbody),
          input = $('<input type="checkbox" id="columns_' + cols[i] + '" name="columns[' + cols[i] + ']" value="1" />').appendTo(container);

      if (selected.indexOf(cols[i]) > -1)
        input.attr('checked', 'checked');
    }

    thead.append('<th><label for="columns_select">Select an action</label></th>');
    tbody.append('<td><input type="checkbox" id="columns_select" name="columns[select]" value="1" checked disabled /></td>')

    var submit = $('<td><input type="Submit" value="Save" class="btn btn-primary" /></td>').appendTo(tfoot);
        cancel = $('<td><a href="#" class="btn btn-primary">Cancel</a></td>').appendTo(tfoot);

    cancel.click(function() { form.toggle(); });

    toolbar.before(form);
  }

  /*
     'My plans' filtering
   */
  var rows = $('#dmp_table tbody tr');

  $('#filter').keyup(function() {
    var query = $(this).val(),
          len = query.length;

    if (len == 0)
      return rows.show();

    if (len < 3)
      return;

    rows.show();
    rows.each(function() {
      var row = $(this);
      console.log(row.text());
      if (!row.text().match(new RegExp(query)))
        row.hide();
    });
  });

});
