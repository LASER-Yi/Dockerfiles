FROM nextcloud:latest

RUN apt-get update \
    && apt-get install software-properties-common \
    && add-apt-repository universe && apt upgrade \
    && apt-get install ffmpeg imagemagick ghostscript exiftool