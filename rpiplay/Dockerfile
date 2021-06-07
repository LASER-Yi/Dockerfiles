FROM debian:latest as compileOS

RUN apt update && apt install -y git cmake libavahi-compat-libdnssd-dev libplist-dev libssl-dev g++ wget zip

RUN wget https://github.com/raspberrypi/firmware/archive/master.zip \
    && unzip master.zip 'firmware-master/opt/*' -d . \
    && mv firmware-master/opt/vc/ /opt

RUN git clone --depth 1 https://github.com/FD-/RPiPlay.git \
    && cd RPiPlay \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make

FROM debian:latest

COPY --from=compileOS /RPiPlay/build/rpiplay /RPiPlay/build/lib* /usr/bin/

ENTRYPOINT [ "rpiplay" ]