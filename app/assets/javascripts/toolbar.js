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

  function get_locale_string() {
                  var current_path = window.location.pathname;
                  var current_locale = current_path.split("/")[1];
                  var strings = {};
                  if(current_locale == "fr"){
                      strings['instruction']  = "<p>Les points que vous sélectionnez seront affichés dans le tableau ci-dessous. Vous pouvez trier les données par en-tête ou les filtrer en indiquant une chaîne de texte dans la case de recherche.</p>";
                      strings['select_action'] = 'Sélectionnez une action'
		      strings['save'] = "Enregistrer"
                      strings['cancel'] = "Annuler"
                      }
                  else{
                      strings['instruction'] = "<p>The items you select here will be displayed in the table below. You can sort the data by each of these headings or filter by entering a text string in the search box.</p>"
                      strings['select_action'] = 'Select an action' 
                      strings['save'] = "Save"
                      strings['cancel'] = "Cancel"
                      }
                  return strings;

  }

  function get_locale_labels() {

  var labels_locale = {};
  labels_locale['name'] = "Nom"
  labels_locale['owner'] = "Propriétaire"
  labels_locale['shared'] = "Partagé?"
  labels_locale['template_owner'] = "Propriétaire du modèle"
  labels_locale['last_edited'] = "Dernière modification"
  labels_locale['identifier'] = "Identifiant"
  labels_locale['grant_number'] = "Numéro de la subvention"
  labels_locale['principal_investigator'] = "Chercheur principal/chercheur"
  labels_locale['data_contact'] = "Personne-ressource pour les données du plan"
  labels_locale['description'] = "Description"
  return labels_locale
}
  function get_locale() {
     var current_path = window.location.pathname;
     var current_locale = current_path.split("/")[1];
    return current_locale
  }

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
    table.after(get_locale_string()['instruction']);

    // Default name column
    table.before('<input type="hidden" name="columns[name]" value="1" />');
    thead.append('<th><label for="columns_name">Name</label></th>');
    tbody.append('<td><input type="checkbox" id="columns_name" name="columns[name]" value="1" checked disabled /></td>')

    for (var i = 0, len = cols.length; i < len; i++) {
      var title 
      var locale = get_locale()
      labels_locale = get_locale_labels()
if (locale == 'en') { title = cols[i].replace(/^\w|_/g, function(c) { return c === '_' ? ' ' : c.toUpperCase(); })}
      else if (locale == 'fr')  { en_title = cols[i];
      title = labels_locale[en_title] }// FIXME: add titles to response for I18n?
          label = $('<th><label for="columns_' + cols[i] + '">' + title + '</label></th>').appendTo(thead),
      container = $('<td></td>').appendTo(tbody),
          input = $('<input type="checkbox" id="columns_' + cols[i] + '" name="columns[' + cols[i] + ']" value="1" />').appendTo(container);

      if (selected.indexOf(cols[i]) > -1)
        input.attr('checked', 'checked');
    }

    thead.append('<th><label for="columns_select">'+get_locale_string()['select_action']+'</label></th>');
    tbody.append('<td><input type="checkbox" id="columns_select" name="columns[select]" value="1" checked disabled /></td>')

    var submit = $('<td><input type="Submit" value='+get_locale_string()["save"]+' class="btn btn-primary" /></td>').appendTo(tfoot);
        cancel = $('<td><a href="#" class="btn btn-primary">'+get_locale_string()['cancel']+'</a></td>').appendTo(tfoot);

    cancel.click(function(e) {
      e.preventDefault();
      form.toggle();
    });

    toolbar.before(form);
  }

  /*
     'My plans' filtering
   */
  var no_matches_message = $('<tr style="display: none;"><td colspan="20">No matches</td></tr>').appendTo($('#dmp_table tbody')),
                    rows = $('#dmp_table tbody tr'),
                  filter = $('#filter');

  filter.keyup(function() {
    var query = $(this).val(),
          len = query.length,
    filter_re = new RegExp(query, 'i'),
      matched = false;

    if (len < 2) {
      rows.show();
      no_matches_message.hide();
      return;
    }

    no_matches_message.hide();

    rows.each(function() {
      var row = $(this);
      row.text().match(filter_re) ? (matched = true && row.show()) : row.hide();
    });

    if (!matched)
      no_matches_message.show();
  });

  $('#clear_filter').click(function(e) {
    e.preventDefault();

    filter.val('');
    rows.show();
    no_matches_message.hide();
  });

 $('#filter_form').submit(function(e) { e.preventDefault() } );

});
