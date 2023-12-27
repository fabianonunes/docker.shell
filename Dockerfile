FROM golang:latest as builder
RUN go install github.com/go-delve/delve/cmd/dlv@latest

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
    fio                                              \
    gpg                                              \
    hey                                              \
    htop                                             \
    iperf3                                           \
    iproute2                                         \
    jq                                               \
    nano                                             \
    parallel                                         \
    pid1                                             \
    psmisc                                           \
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

COPY --from=builder /go/bin/dlv /usr/local/bin/dlv

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "entrypoint.sh" ]
