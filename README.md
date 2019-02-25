[![Docker Build Status](https://img.shields.io/docker/build/piec/transmission-magnet.svg)](https://hub.docker.com/r/piec/transmission-magnet/)
[![](https://images.microbadger.com/badges/image/piec/transmission-magnet.svg)](https://microbadger.com/images/piec/transmission-magnet "Get your own image badge on microbadger.com")

# docker-transmission-magnet
docker image for transmission with support of magnet link files watch

Derived from linuxserver docker image + third party patch:
* https://github.com/linuxserver/docker-transmission
* https://trac.transmissionbt.com/ticket/4710#comment:18

# Usage

```
docker run -it --name transmission \
  --restart unless-stopped \
  -v <path to config>:/config \
  -v <path to downloads>:/downloads \
  -v <path to watch folder>:/watch \
  -v /etc/localtime:/etc/localtime:ro \
  -e PUID=<uid> \
  -e PGID=<gid> \
  -p 9091:9091
  -p 51413:51413 \
  -p 51413:51413/udp \
  piec/transmission-magnet
```
See also https://github.com/linuxserver/docker-transmission#usage

Alternately you can use `docker-compose` + [traefik](https://docs.traefik.io/) with the template `docker-compose.yml` file
