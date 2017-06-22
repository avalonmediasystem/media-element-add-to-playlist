addnew = 'Add new playlist'

$('#post_playlist_id').append('<option>Add new playlist</option>')

matchWithNew = (params, data) ->
  params.term = params.term || ''
  if (data.text.indexOf(addnew) != -1 || data.text.indexOf(params.term) != -1)
    return data;
  return null;

formatAddNew = (data) ->
  if ($('.select2-search__field')[0])
    term = $('.select2-search__field')[0].value || ''
  term = addnew + term
  if (data.text.indexOf('Add new playlist') != -1 )
    return '<a>
              <i class="fa fa-plus" aria-hidden="true"></i> <b>'+term+'</b>
            </a>'
  return data.text

$("#post_playlist_id").select2({
  templateResult: formatAddNew
  escapeMarkup:
    (markup) -> return markup
  matcher: matchWithNew
  })
  .on('select2:select',
    (evt) ->
      choice = evt.params.data.text
      if (choice.indexOf(addnew) != -1)
        alert('boop')
  )
