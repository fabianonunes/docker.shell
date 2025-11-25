# syntax=docker/dockerfile:1.4
FROM golang:latest as builder
RUN go install github.com/go-delve/delve/cmd/dlv@latest
RUN go install github.com/codesenberg/bombardier@latest
RUN go install github.com/gcla/termshark/v2/cmd/termshark@v2.4.0

FROM ubuntu:24.04
SHELL ["/bin/bash", "-exc"]
ENV LANG C.UTF-8

ARG TZ=UTC
RUN <<EOT
  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime;
  apt-get update;
  apt-get install --no-install-recommends -y  \
    apache2-utils                             \
    bridge-utils                              \
    busybox                                   \
    ca-certificates                           \
    conntrack                                 \
    curl                                      \
    dhcping                                   \
    ethtool                                   \
    gnutls-bin                                \
    gpg                                       \
    hey                                       \
    hping3                                    \
    htop                                      \
    iftop                                     \
    iperf3                                    \
    iproute2                                  \
    iptables                                  \
    iptraf-ng                                 \
    iputils-arping                            \
    ipvsadm                                   \
    jq                                        \
    knot-dnsutils                             \
    ldnsutils                                 \
    nano                                      \
    net-tools                                 \
    netcat-openbsd                            \
    netperf                                   \
    nftables                                  \
    ngrep                                     \
    pid1                                      \
    psmisc                                    \
    pv                                        \
    rclone                                    \
    restic                                    \
    rsync                                     \
    socat                                     \
    strace                                    \
    sudo                                      \
    sysbench                                  \
    sysstat                                   \
    tcpdump                                   \
    tcptraceroute                             \
    tshark                                    \
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
COPY --from=ghcr.io/astral-sh/uv:0.9.11 /uv /uvx /usr/local/bin/
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "pid1" ]
CMD [ "sleep", "infinity" ]
