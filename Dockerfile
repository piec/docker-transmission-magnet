#FROM andyshinn/alpine-abuild:v11
FROM piec/docker-alpine-build:v11

RUN mkdir ~/work
COPY apk /home/builder/work
WORKDIR /home/builder/work

RUN abuild-keygen -a
RUN sudo apk update
RUN abuilder -r

FROM lsiobase/alpine:3.12

COPY --from=0 /packages /packages
# set version label
ARG BUILD_DATE
ARG VERSION
ARG TRANSMISSION_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="aptalca"

RUN \
 echo "**** install packages ****" && \
 apk add --no-cache \
	curl \
	findutils \
	jq \
	openssl \
	p7zip \
	python3 \
	rsync \
	tar \
	unrar \
	unzip

RUN apk add --no-cache \
    --allow-untrusted --repository /packages/builder \
    transmission-cli transmission-daemon

RUN \
 echo "**** install third party themes ****" && \
 curl -o \
	/tmp/combustion.zip -L \
	"https://github.com/Secretmapper/combustion/archive/release.zip" && \
 unzip \
	/tmp/combustion.zip -d \
	/ && \
 mkdir -p /tmp/twctemp && \
 TWCVERSION=$(curl -sX GET "https://api.github.com/repos/ronggang/transmission-web-control/releases/latest" \
	| awk '/tag_name/{print $4;exit}' FS='[""]') && \
 curl -o \
	/tmp/twc.tar.gz -L \
	"https://github.com/ronggang/transmission-web-control/archive/${TWCVERSION}.tar.gz" && \
 tar xf \
	/tmp/twc.tar.gz -C \
	/tmp/twctemp --strip-components=1 && \
 mv /tmp/twctemp/src /transmission-web-control && \
 mkdir -p /kettu && \
 curl -o \
	/tmp/kettu.tar.gz -L \
	"https://github.com/endor/kettu/archive/master.tar.gz" && \
 tar xf \
	/tmp/kettu.tar.gz -C \
	/kettu --strip-components=1 && \
 echo "**** cleanup ****" && \
 rm -rf \
	/tmp/*


# copy local files
COPY root/ /

# ports and volumes
EXPOSE 9091 51413
VOLUME /config /downloads /watch
