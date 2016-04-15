FROM alpine:3.3
MAINTAINER Ross Hendry "rhendry@googlemail.com"

RUN echo "@testing http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

RUN apk add --update openjdk8-jre curl bash procps openssh java-snappy@testing supervisor
RUN mkdir -p ~root/.ssh /var/log/supervisor && chmod 700 ~root/.ssh/ && \
    echo -e "Port 22\n" >> /etc/ssh/sshd_config && \
    cp -a /etc/ssh /etc/ssh.cache && \
    rm -rf /var/cache/apk/*

RUN curl -s http://d3kbcqa49mib13.cloudfront.net/spark-1.6.1-bin-hadoop2.6.tgz | tar -xz -C /usr/local && \
  cd /usr/local/ && \
  ln -s spark-1.6.1-bin-hadoop2.6 spark && \
  rm spark/lib/spark-examples-1.6.1-hadoop2.6.0.jar

ENV SPARK_HOME /usr/local/spark
WORKDIR /usr/local/spark
