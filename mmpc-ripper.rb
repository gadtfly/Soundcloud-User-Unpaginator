require_relative 'secrets'
require 'soundcloud'

USER_URL  = 'https://soundcloud.com/themonday-morning-podcast'
MAX_LIMIT = 200
CLIENT_ID = Secrets::Soundcloud::CLIENT_ID

def get_page(path, options, page)
  client = SoundCloud.new(client_id: CLIENT_ID)
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

client = SoundCloud.new(client_id: CLIENT_ID)
user = client.get('/resolve', url: USER_URL)
tracks = concatenate_paginated("/users/#{user.id}/tracks")
p user['track_count'], tracks.size
