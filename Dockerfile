# Pull base image
FROM openjdk:8-jdk-slim

MAINTAINER Ivan Subotic "ivan.subotic@unibas.ch"

# Env variables
ENV SBT_VERSION 1.2.1

# Install curl
RUN \
  apt-get update && \
  apt-get -y install wget

# Install sbt
RUN \
  wget https://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
  dpkg -i sbt-$SBT_VERSION.deb && \
  rm sbt-$SBT_VERSION.deb && \
  apt-get update && \
  apt-get install sbt

# Install YourKit profiler agent
RUN wget https://www.yourkit.com/download/docker/YourKit-JavaProfiler-2018.04-docker.zip -P /tmp/ && \
    unzip /tmp/YourKit-JavaProfiler-2018.04-docker.zip -d /usr/local && \
    rm /tmp/YourKit-JavaProfiler-2018.04-docker.zip

EXPOSE 3333
EXPOSE 10001

# Make source directory
RUN mkdir /src

# Define working directory
WORKDIR /src
