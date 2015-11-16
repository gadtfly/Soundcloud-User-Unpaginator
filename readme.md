# Soundcloud User Unpaginator

Because paging through an infinite-scrolling index 20 things at a time to try to get to #250 is... unnecessarily unpleasant.

Supply a [SOUNDCLOUD_CLIENT_ID](http://soundcloud.com/you/apps) environment variable, eg:

```bash
SOUNDCLOUD_CLIENT_ID=yourkeyhere
```

Start the server:

```bash
rackup -p 4567
```

Browse:

[http://localhost:4567/](http://localhost:4567/) and fill in the box with the user whose tracks you want the full index of, leading to, eg:  
[http://localhost:4567/?url=https%3A%2F%2Fsoundcloud.com%2Fthemonday-morning-podcast](http://localhost:4567/?url=https%3A%2F%2Fsoundcloud.com%2Fthemonday-morning-podcast)
