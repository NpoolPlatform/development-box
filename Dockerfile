FROM jrei/systemd-ubuntu:20.04

USER root
ARG ENV_ENVIRONMENT_TARGET
ARG ENV_CONSUL_HOST
ARG ENV_CONSUL_PORT
ARG PATH

RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list

RUN apt-get update -y
RUN apt-get install git make curl jq golang-go wget apt-utils vim net-tools sudo iputils-ping iproute2 openssh-server nfs-common dnsutils -y

COPY .tmp/go /usr/bin/go
ENV GOBIN=/usr/bin

COPY docker-entrypoint.sh /usr/local/bin
RUN chmod a+x /usr/local/bin/docker-entrypoint.sh

CMD ["sh"]
