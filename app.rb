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
%table
  %thead
    %tr
      %th id
      %th title
      %th description
      - @tracks.first.counts.keys.each do |count_key|
        %th= count_key
  %tbody
    - @tracks.each do |track| 
      %tr
        %td= track.id
        %td
          %a{href: track.authorized_stream_url, download: true}= track.title
        %td= track.description
        - track.counts.values.each do |count_value|
          %td= count_value
