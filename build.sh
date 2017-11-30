#!/bin/sh
DEPS_PACKAGES="libnice10 libglib2.0-0 libjansson4 libssl1.0.0 libcurl3 libsofia-sip-ua0 libogg0 libopus0 libmicrohttpd10 git wget curl"
BUILD_PACKAGES="build-essential libmicrohttpd-dev libjansson-dev libnice-dev libssl-dev libsrtp-dev libsofia-sip-ua-dev libglib2.0-dev libopus-dev libogg-dev libcurl4-openssl-dev libavutil-dev libavcodec-dev libavformat-dev pkg-config gengetopt libtool automake cmake"
set -e
cd /root
apt-get update && apt-get install -y $DEPS_PACKAGES $BUILD_PACKAGES && rm -rf /var/lib/apt/lists/*
wget https://github.com/cisco/libsrtp/archive/v2.0.0.tar.gz
tar xfv v2.0.0.tar.gz && rm -rf v2.0.0.tar.gz
cd libsrtp-2.0.0
./configure --prefix=/usr --enable-openssl
make shared_library && make install
cd /root
rm -rf libsrtp-2.0.0
git clone https://github.com/sctplab/usrsctp
cd usrsctp
./bootstrap
./configure --prefix=/usr && make && make install
cd /root
rm -rf usrsctp
git clone https://github.com/warmcat/libwebsockets.git
cd libwebsockets
git checkout v2.2-stable
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr -DCMAKE_C_FLAGS="-fpic" ..
make && make install
cd /root
rm -rf libwebsockets
git clone https://github.com/meetecho/janus-gateway.git
cd janus-gateway
sh autogen.sh
./configure --prefix=/opt/janus --enable-post-processing
make
make install
make configs
cd /root
rm -rf janus-gateway
apt-get autoremove -y $BUILD_PACKAGES
cp -R /opt/janus/etc/janus /root/janus
apt-get clean
rm -rf build.sh
