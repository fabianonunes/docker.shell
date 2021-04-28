FROM ubuntu:20.04

ENV LANG C.UTF-8

ARG TZ=UTC
RUN set -ex;                                         \
  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime;    \
  apt-get update;                                    \
  apt-get install --no-install-recommends -y         \
    curl                                             \
    iproute2                                         \
    iputils-ping                                     \
    dnsutils                                         \
    nano                                             \
    net-tools                                        \
    netcat-openbsd                                   \
    parallel                                         \
    pid1                                             \
    tcpdump                                          \
  ;                                                  \
  rm -rf /var/lib/apt/lists/*;

ENTRYPOINT [ "pid1", "--" ]
CMD [ "tail", "-f", "/dev/null" ]
