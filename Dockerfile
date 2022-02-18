FROM ubuntu:20.04

ENV LANG C.UTF-8

ARG TZ=UTC
RUN set -ex;                                         \
  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime;    \
  apt-get update;                                    \
  apt-get install --no-install-recommends -y         \
    apache2-utils                                    \
    ca-certificates                                  \
    curl                                             \
    dnsutils                                         \
    hey                                              \
    iproute2                                         \
    iputils-ping                                     \
    jq                                               \
    nano                                             \
    net-tools                                        \
    netcat-openbsd                                   \
    parallel                                         \
    pid1                                             \
    sysstat                                          \
    tcpdump                                          \
    telnet                                           \
    wget                                             \
  ;                                                  \
  rm -rf /var/lib/apt/lists/*;

ENTRYPOINT [ "pid1", "--" ]
CMD [ "tail", "-f", "/dev/null" ]
