addnew = 'Add new playlist'

$('#post_playlist_id').append('<option>Add new playlist</option>')

getSearchTerm = () ->
  if $('.select2-search__field')[0]
    return $('.select2-search__field')[0].value
  return null

matchWithNew = (params, data) ->
  params.term = params.term || ''
  if (data.text.indexOf(addnew) != -1 || data.text.indexOf(params.term) != -1)
    return data;
  return null;

formatAddNew = (data) ->
  term = getSearchTerm() || ''
  term = addnew + ' ' + term
  if (data.text.indexOf('Add new playlist') != -1 )
    return '<a>
              <i class="fa fa-plus" aria-hidden="true"></i> <b>'+term+'</b>
            </a>'
  return data.text

showNewPlaylistModal = (playlistName) ->
  console.log(playlistName)

$("#post_playlist_id").select2({
  templateResult: formatAddNew
  escapeMarkup:
    (markup) -> return markup
  matcher: matchWithNew
  })
  .on('select2:selecting',
    (evt) ->
      choice = evt.params.args.data.text
      if (choice.indexOf(addnew) != -1)
        showNewPlaylistModal(getSearchTerm())
  )
