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

Alternately you can use `docker-compose` + traefik with the template `docker-compose.yml` file

