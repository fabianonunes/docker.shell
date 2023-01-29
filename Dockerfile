FROM ubuntu:22.04

ENV LANG C.UTF-8

ARG TZ=UTC
RUN set -ex;                                         \
  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime;    \
  apt-get update;                                    \
  apt-get install --no-install-recommends -y         \
    apache2-utils                                    \
    busybox                                          \
    ca-certificates                                  \
    curl                                             \
    dnsutils                                         \
    hey                                              \
    iperf3                                           \
    iproute2                                         \
    iputils-ping                                     \
    jq                                               \
    nano                                             \
    net-tools                                        \
    netcat-openbsd                                   \
    parallel                                         \
    pid1                                             \
    socat                                            \
    sysstat                                          \
    tcpdump                                          \
    telnet                                           \
    wget                                             \
  ;                                                  \
  rm -rf /var/lib/apt/lists/*;

ENTRYPOINT [ "pid1", "--" ]
CMD [ "tail", "-f", "/dev/null" ]
