module MediaElementAddToPlaylist
  class Engine < ::Rails::Engine
    isolate_namespace MediaElementAddToPlaylist
    config.assets.precompile += %w( select2.min.css select2.min.js add-playlist-option.js)
  end
end
