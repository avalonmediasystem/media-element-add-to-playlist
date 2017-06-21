  $("#post_playlist_id").select2({
    language: {
      noResults: () ->
        term = $('.select2-search__field')[0].value || Playlist
        return '<a href="http://google.com">Add '+term+ '</a>'
    }
    escapeMarkup:
      (markup) -> return markup
    });
