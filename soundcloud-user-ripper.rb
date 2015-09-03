require_relative 'secrets'
require 'soundcloud'

MAX_LIMIT = 200
CLIENT_ID = Secrets::Soundcloud::CLIENT_ID

def client
  SoundCloud.new(client_id: CLIENT_ID)
end

def get_page(path, options, page)
  client.get(path, options.merge(limit: MAX_LIMIT, offset: page * MAX_LIMIT))
end

def concatenate_paginated(path, options = {})
  page = 0
  results = []
  while results.size < (results += get_page(path, options, page)).size
    page += 1
  end
  results
end

def get_all_tracks(user_url)
  user = client.get('/resolve', url: user_url)
  concatenate_paginated("/users/#{user.id}/tracks").map(&method(:append_authorized_stream_url))
end

def append_authorized_stream_url(track)
  track.merge(authorized_stream_url: "#{track.stream_url}?client_id=8e2ec365cc5150de0342371f981db03f")
end
