# syntax=docker/dockerfile:1.4
FROM golang:latest as builder
RUN go install github.com/go-delve/delve/cmd/dlv@latest
RUN go install github.com/codesenberg/bombardier@latest

FROM ubuntu:24.04
SHELL ["/bin/bash", "-exc"]
ENV LANG C.UTF-8

ARG TZ=UTC
RUN <<EOT
  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime;
  apt-get update;
  apt-get install --no-install-recommends -y  \
    apache2-utils                             \
    busybox                                   \
    ca-certificates                           \
    curl                                      \
    dnsutils                                  \
    fio                                       \
    gpg                                       \
    hey                                       \
    hping3                                    \
    htop                                      \
    iperf3                                    \
    iproute2                                  \
    jq                                        \
    nano                                      \
    net-tools                                 \
    netcat-openbsd                            \
    parallel                                  \
    pid1                                      \
    psmisc                                    \
    pv                                        \
    socat                                     \
    strace                                    \
    sudo                                      \
    sysbench                                  \
    sysstat                                   \
    tcpdump                                   \
    vmtouch                                   \
    wait-for-it                               \
    wget                                      \
    wrk                                       \
  ;
  echo "ALL ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
  busybox --install
  rm -rf /var/lib/apt/lists/*;
EOT

COPY --from=builder /go/bin/ /usr/local/bin/
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "entrypoint.sh" ]
