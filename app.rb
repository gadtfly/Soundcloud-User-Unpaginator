require_relative 'soundcloud-user-ripper'
require 'sinatra'
require 'haml'

get '/' do
  @tracks = params[:url] ? get_all_tracks(params[:url]) : []
  haml :main
end

__END__

@@layout
!!! 5
%html
  %head
    %link{rel: :stylesheet, href: 'https://cdnjs.cloudflare.com/ajax/libs/sortable/0.6.0/css/sortable-theme-minimal.css'}
    %script{src: 'https://cdnjs.cloudflare.com/ajax/libs/sortable/0.6.0/js/sortable.min.js'}
  %body
    %form{method: :get}
      %input{name: :url}
    = yield

@@main
- unless @tracks.empty?
  %table{data: {sortable: true}}
    %thead
      %tr
        %th Title
        %th{data: {sortable: 'false'}} Description
        - @tracks.first.counts.keys.each do |count_key|
          %th= count_key.capitalize
    %tbody
      - @tracks.each do |track| 
        %tr
          %td{data: {value: track.id}}
            %a{href: track.authorized_stream_url, download: true}= track.title
          %td= track.description
          - track.counts.values.each do |count_value|
            %td= count_value
