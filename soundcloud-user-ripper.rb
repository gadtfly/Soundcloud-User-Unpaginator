require_relative 'core_extensions'
require_relative 'secrets'
require 'soundcloud'

def client
  SoundCloud.new(client_id: Secrets::Soundcloud::CLIENT_ID)
end

def get_page(path, options, page)
  max_limit = 200
  client.get(path, options.merge(limit: max_limit, offset: page * max_limit))
end

def concatenate_paginated(path, options = {})
  0.unfold do |page|
    result = get_page(path, options, page)
    result.empty? ? nil : [result, page+1]
  end.flatten
end

def get_all_tracks(user_url)
  user = client.get('/resolve', url: user_url)
  concatenate_paginated("/users/#{user.id}/tracks").map(&method(:decorate))
end

def decorate(track)
  track.merge(authorized_stream_url: "#{track.stream_url}?client_id=8e2ec365cc5150de0342371f981db03f",
              counts: track.select{|key, value| key.end_with?('count')}.map_keys{|key| key.split('_').first})
end
