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
    jq                                               \
    nano                                             \
    parallel                                         \
    pid1                                             \
    socat                                            \
    sysstat                                          \
    tcpdump                                          \
    wget                                             \
  ;                                                  \
  rm -rf /var/lib/apt/lists/*;

ENTRYPOINT [ "pid1", "--" ]
CMD [ "tail", "-f", "/dev/null" ]
