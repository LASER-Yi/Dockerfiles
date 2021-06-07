FROM debian:latest as compileOS

RUN apt update && api install git cmake libavahi-compat-libdnssd-dev libplist-dev libssl-dev g++ wget zip

RUN wget https://github.com/raspberrypi/firmware/archive/master.zip \
    && unzip master.zip 'firmware-master/opt/*' -d . \
    && mv firmware-master/opt/vc/ /opt

RUN git clone --depth=1 https://github.com/FD-/RPiPlay.git \
    pushd RPiPlay \
    mkdir build \
    cp /usr/lib/arm-linux-gnueabihf/libdns_sd.so.1 ./build/ \
    && printf "\nadd_library(dns_sd SHARED IMPORTED GLOBAL)\nset_target_properties(dns_sd PROPERTIES IMPORTED_LOCATION \"./libdns_sd.so.1\")\n" >>./lib/CMakeLists.txt

RUN pushd build \
    && cmake .. \
    && make
