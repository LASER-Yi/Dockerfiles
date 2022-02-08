FROM nextcloud:latest

RUN apt-get update \
    && apt-get install -y software-properties-common \
    && add-apt-repository universe && apt -y upgrade \
    && apt-get install -y ffmpeg imagemagick ghostscript exiftool \
    && apt-get clean