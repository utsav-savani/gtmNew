#Stage 1 - Install dependencies and build the app
FROM cirrusci/flutter:latest AS build-env

RUN apt-get update
RUN apt-get install -y apt-utils curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3 psmisc lsof
#RUN apt-get install -y python3-pip
RUN apt-get clean
#RUN pip install flask

# Enable flutter web
RUN flutter config --enable-web

# Copy files to container and build
RUN mkdir /app/
COPY . /app/
WORKDIR /app/

ENV PATH="$PATH":"$HOME/.pub-cache/bin"

ARG versionNumber
RUN echo $versionNumber > assets/versionNumber.txt

ARG URL
ENV URL=$URL

ARG ENVIRONMENT
ENV ENVIRONMENT=$ENVIRONMENT

ARG APIBASEURL
ENV APIBASEURL=$APIBASEURL

RUN echo "ENVIRONMENT=${ENVIRONMENT}"> .env
RUN echo "APIBASEURL=${APIBASEURL}">> .env
RUN echo "TMSAPIBASEURL=${APIBASEURL}/api">> .env
RUN cat .env_static >> .env

RUN flutter pub get
RUN flutter build web -t lib/main.dart

EXPOSE 443

# Set the server startup script as executable
RUN ["chmod", "+x", "/app/server/server.sh"]

# Start the web server
ENTRYPOINT ["/app/server/server.sh"]
