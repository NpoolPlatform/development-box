FROM jrei/systemd-ubuntu:20.04

USER root

RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list

RUN apt-get update -y
RUN apt-get install git make curl jq golang-go wget apt-utils vim net-tools sudo iputils-ping iproute2 openssh-server nfs-common dnsutils -y

COPY .docker-tmp/go /usr/bin/go
COPY .docker-tmp/consul /usr/bin/consul
ENV GOBIN=/usr/bin

CMD ["/bin/bash"]
