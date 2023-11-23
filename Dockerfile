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
    gpg                                              \
    hey                                              \
    iperf3                                           \
    iproute2                                         \
    jq                                               \
    nano                                             \
    parallel                                         \
    pid1                                             \
    pv                                               \
    socat                                            \
    strace                                           \
    sysbench                                         \
    sysstat                                          \
    tcpdump                                          \
    vmtouch                                          \
    wait-for-it                                      \
    wget                                             \
  ;                                                  \
  rm -rf /var/lib/apt/lists/*;                       \
  busybox --install

ENTRYPOINT [ "pid1", "--" ]
CMD [ "tail", "-f", "/dev/null" ]
