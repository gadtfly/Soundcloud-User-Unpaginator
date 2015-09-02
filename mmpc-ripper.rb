require_relative 'secrets'
require 'open-uri'
require 'json'

API_URL   = 'https://api.soundcloud.com'
USER_URL  = 'https://soundcloud.com/themonday-morning-podcast'
MAX_LIMIT = 200
CLIENT_ID = Secrets::Soundcloud::CLIENT_ID



def querystringify(hash)
  hash.map{|k,v| "#{k}=#{v}"}.join('&')
end

def api(path, options = {})
  options.merge!(client_id: CLIENT_ID)
  JSON.parse(open("#{API_URL}#{path}?#{querystringify(options)}").read)
end

def get_page(path, options, page)
  api(path, options.merge(limit: MAX_LIMIT, offset: page * MAX_LIMIT))
end

def concatenate_paginated(path, options = {})
  page = 0
  results = []
  while results.size < (results += get_page(path, options, page)).size
    page += 1
  end
  results
end

user = api('/resolve', url: USER_URL)
tracks = concatenate_paginated("/users/#{user['id']}/tracks")
p user['track_count'], tracks.size
