# Pull base image
FROM openjdk:13-jdk-slim

MAINTAINER Ivan Subotic "400790+subotic@users.noreply.github.com"

ENV SCALA_VERSION 2.12.8
ENV SBT_VERSION 1.2.8

ENV PATH /sbt/bin:$PATH

# Install curl
RUN \
  apt-get update && \
  apt-get -y install wget

# Install Scala
## Piping wget directly into tar
RUN \
  wget -O - https://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C /root/ && \
  echo >> /root/.bashrc && \
  echo "export PATH=~/scala-$SCALA_VERSION/bin:$PATH" >> /root/.bashrc

# Install SBT
## Piping wget directly into tar
RUN \
  wget -O - https://github.com/sbt/sbt/releases/download/v$SBT_VERSION/sbt-$SBT_VERSION.tgz | tar xfz - -C / && \
  sbt sbtVersion

# Make source directory
RUN mkdir /src

# Define working directory
WORKDIR /src
