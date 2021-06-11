FROM golang:stretch as hey

WORKDIR /app

RUN set -ex;                                                                \
    git clone --branch v0.1.4 --depth 1 https://github.com/rakyll/hey.git;  \
    cd hey;                                                                 \
    make release

RUN ls -la /app

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
    iproute2                                         \
    iputils-ping                                     \
    jq                                               \
    nano                                             \
    net-tools                                        \
    netcat-openbsd                                   \
    parallel                                         \
    pid1                                             \
    tcpdump                                          \
    telnet                                           \
    wget                                             \
  ;                                                  \
  rm -rf /var/lib/apt/lists/*;

COPY --from=hey /app/hey/bin/hey_linux_amd64 /usr/bin/hey

ENTRYPOINT [ "pid1", "--" ]
CMD [ "tail", "-f", "/dev/null" ]
