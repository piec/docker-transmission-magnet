FROM andyshinn/alpine-abuild:v6

RUN mkdir ~/work
COPY apk /home/builder/work
WORKDIR /home/builder/work

RUN abuild-keygen -a
RUN sudo apk update
RUN abuilder -r

FROM lsiobase/alpine:3.7

COPY --from=0 /packages /packages
RUN \
    echo "**** install packages ****" && \
    apk add --no-cache \
    curl \
    jq \
    openssl \
    p7zip \
    rsync \
    tar \
    unrar \
    unzip

RUN apk add --no-cache \
    --allow-untrusted --repository /packages/builder \
    transmission-cli transmission-daemon

COPY root/ /

EXPOSE 9091 51413

VOLUME /config /downloads /watch
