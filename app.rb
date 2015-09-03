require_relative 'soundcloud-user-ripper'
require 'sinatra'
require 'haml'

get '/' do
  @tracks = params[:url] ? get_all_tracks(params[:url]) : []
  haml :main
end

__END__

@@main
%form{method: :get}
  %input{name: :url}
%ul
  - @tracks.each do |track|
    %li
      %h3
        %a{href: track.authorized_stream_url, download: true}= track.title
      = track.description
