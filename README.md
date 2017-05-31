[![Docker Stars](https://img.shields.io/docker/stars/giordanocardillo/janus-fromsrc-wsonly.svg?style=flat-square)](https://hub.docker.com/r/giordanocardillo/janus-fromsrc-wsonly/) [![Docker Pulls](https://img.shields.io/docker/pulls/giordanocardillo/janus-fromsrc-wsonly.svg?style=flat-square)](https://hub.docker.com/r/giordanocardillo/janus-fromsrc-wsonly/) [![Docker Automated build](https://img.shields.io/docker/automated/giordanocardillo/janus-fromsrc-wsonly.svg?style=flat-square)](https://hub.docker.com/r/giordanocardillo/janus-fromsrc-wsonly/)

# Janus WebRTC compiled from sources as follows

```
libsrtp version:           2.0.x
SSL/crypto library:        OpenSSL
DataChannels support:      yes
Recordings post-processor: yes
TURN REST API client:      yes
Doxygen documentation:     no
Transports:
    REST (HTTP/HTTPS):     yes
    WebSockets:            yes (new API)
    RabbitMQ:              no
    MQTT:                  no
    Unix Sockets:          yes
Plugins:
    Echo Test:             yes
    Streaming:             yes
    Video Call:            yes
    SIP Gateway:           yes
    Audio Bridge:          yes
    Video Room:            yes
    Voice Mail:            yes
    Record&Play:           yes
    Text Room:             yes
Event handlers:
    Sample event handler:  yes
```

## Pulling the image
The image is available on docker hub as automated build

```
docker pull giordanocardillo/janus-fromsrc-wsonly
```

## Running the container
A run configuration could be the following (host network is advisable to avoid ICE problems)

```
docker run -d --network=host -p 8188:8188 -p 8989:8989 -p 8088:8088 -p 8089:8089 -v /root/janus:/opt/janus/etc/janus --name janus giordanocardillo/janus-fromsrc-wsonly
```  

## Configuration samples
Configuration is shipped within the container, to copy it to the host machine use the following command (after the container is started)

```
docker cp janus:/root/janus /root/janus
```

Then restart the container

```
docker restart janus
```

## Converting recorded files

The image is configured to provide `janus-pp-rec` utility to convert recorded files and is stored in `/opt/janus/bin/janus-pp-rec`

The image in this branch is **based on Ubuntu 16.04**, so you **must** use that OS to make the executable work.

To make it work, the following libraries must be installed

* `libglib`
* `libjansson`
* `libavutil`
* `libavcodec`
* `libavformat`

```
sudo apt-get install -y libglib2.0-0 libjansson4 libavutil-ffmpeg54 libavcodec-ffmpeg56 libavformat-ffmpeg56
```

To use it, copy it from the docker container

```
docker cp janus:/opt/janus/bin/janus-pp-rec /usr/local/bin
```

## Credits

Thanks to [Meetecho](http://www.meetecho.com/en/) for the wonderful [Janus](https://janus.conf.meetecho.com/) project
