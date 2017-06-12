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
docker run -d --network=host -v /root/janus:/opt/janus/etc/janus --name janus giordanocardillo/janus-fromsrc-wsonly
```  

## Configuration samples
Configuration is shipped within the container, to copy it to the host machine use the following command (after the container is started)

```
docker cp janus:/root/janus /root
```

Then restart the container

```
docker restart janus
```

## Converting recorded files

The image is configured to provide `janus-pp-rec` utility to convert recorded files and is stored in `/opt/janus/bin/janus-pp-rec`

The image in the master branch is **based on debian 8**, so you **must** use that OS to make the executable work.

To make it work, the following libraries must be installed

* `libjansson`
* `libavutil`
* `libavcodec`
* `libavformat`

```
sudo apt-get install -y libjansson4 libavutil54 libavcodec56 libavformat56
```


To use it, copy it from the docker container

```
docker cp janus:/opt/janus/bin/janus-pp-rec /usr/local/bin
```

Then convert recordings with

```
janus-pp-rec /opt/janus/share/janus/recordings/video.mjr /opt/janus/share/janus/recordings/video.webm
janus-pp-rec /opt/janus/share/janus/recordings/audio.mjr /opt/janus/share/janus/recordings/audio.opus
```

### Merging audio and video

Install ffmpeg

```
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:kirillshkrogalev/ffmpeg-next
sudo apt-get update
sudo apt-get install ffmpeg
``` 

Then merge the files

```
ffmpeg -i audio.opus -i video.webm  -c:v copy -c:a opus -strict experimental mergedoutput.webm
```

## Credits

Thanks to [Meetecho](http://www.meetecho.com/en/) for the wonderful [Janus](https://janus.conf.meetecho.com/) project
