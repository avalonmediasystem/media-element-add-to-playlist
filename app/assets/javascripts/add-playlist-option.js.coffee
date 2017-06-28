addnew = 'Add new playlist'
select_element = $('#post_playlist_id')

select_element.prepend(new Option(addnew))

getSearchTerm = () ->
  if $('.select2-search__field')[0]
    return $('.select2-search__field')[0].value
  return null

matchWithNew = (params, data) ->
  term = params.term || ''
  term = term.toLowerCase()
  text = data.text.toLowerCase()
  if (text.indexOf(addnew.toLowerCase()) != -1 || text.indexOf(term) != -1)
    return data;
  return null;

formatAddNew = (data) ->
  term = getSearchTerm() || ''
  if (data.text.indexOf('Add new playlist') != -1 )
    if (term != '')
      term = addnew + ' "' + term + '"'
    else
      term = addnew
    return '<a>
              <i class="fa fa-plus" aria-hidden="true"></i> <b>'+term+'</b>
            </a>'
  else
    start = data.text.toLowerCase().indexOf(term.toLowerCase())
    if (start != -1)
      end = start+term.length-1
      return data.text.substring(0,start) + '<b>' + data.text.substring(start, end+1) + '</b>' + data.text.substring(end+1)
  return data.text

showNewPlaylistModal = (playlistName) ->
  $('#add-playlist-modal').modal('show')
  $('#new_playlist_submit').val('Create')
  $('#new_playlist_submit').prop("disabled", false)
  return true

select_element.select2({
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

$('#playlist_form').submit(
  () ->
    if($('#playlist_title').val())
      $('#new_playlist_submit').val('Saving...')
      $('#new_playlist_submit').prop("disabled", true)
      return true
    if($('#title_error').length == 0)
      $('#playlist_title').after('<h5 id="title_error" class="error text-danger">Name is required</h5>')
      $('#playlist_title').parent().addClass('has-error')
    return false
)

$("#playlist_form").bind('ajax:success',
  (event, data, status, xhr) ->
    $('#add-playlist-modal').modal('hide')
    if (data.errors)
      console.log(data.errors.title[0])
    else
      select_element.append(new Option(data.title, data.id.toString(), true, true)).trigger('change')
  )
