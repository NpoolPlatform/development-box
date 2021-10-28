FROM jrei/systemd-ubuntu:20.04

USER root

RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list

RUN apt-get update -y
RUN apt-get install git make curl jq wget apt-utils vim net-tools sudo iputils-ping iproute2 openssh-server nfs-common dnsutils -y

ARG ALL_PROXY

RUN all_proxy=$ALL_PROXY curl -sL -o /tmp/go1.16.7.tar.gz https://github.com/golang/go/archive/refs/tags/go1.16.7.tar.gz
RUN mkdir -p /usr/local/go
RUN cd /usr/local/go; tar xvvf go1.16.7.tar.gz
RUN mv /usr/local/go/go-go1.16.7/* /usr/local/go
RUN rm -rf /usr/local/go/go-go1.16.7
RUN cd /usr/local/go/src; ./all.bash
RUN cp /usr/local/go/bin/go /usr/bin/go

COPY .docker-tmp/consul /usr/bin/consul
ENV GOBIN=/usr/bin

CMD ["/bin/bash"]
