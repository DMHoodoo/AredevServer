#FROM nwnxee/builder:latest as builder
FROM debian:buster-slim
CMD ["bash"]
LABEL maintainer=niv@beamdog.com
RUN apt-get update && \
  apt-get --no-install-recommends -y install libc6 libstdc++6 && \
  rm -r /var/cache/apt /var/lib/apt/lists
RUN mkdir -p /nwn/data
RUN mkdir -p /nwn/home
RUN mkdir -p /nwn/run
COPY /data/data /nwn/data/data
ENV NWN_ARCH=linux-x86
COPY /data/bin/linux-x86/nwmain-linux /data/bin/linux-x86/nwserver-linux /nwn/data/bin/linux-x86/
RUN chmod +x /nwn/data/bin/linux-x86/nwserver-linux
COPY /run-server.sh /prep-nwn-ini.awk /prep-nwnplayer-ini.awk /nwn/
RUN chmod +x /nwn/run-server.sh
COPY /data/lang/en/data/dialog.tlk /nwn/data/lang/en/data/
VOLUME /nwn/home
EXPOSE 5121/udp
ENV NWN_TAIL_LOGS=y
ENV NWN_EXTRA_ARGS="-userdirectory /nwn/run"
WORKDIR /nwn/data/bin/linux-x86
ENTRYPOINT "/bin/bash" "/nwn/run-server.sh"
RUN mkdir /nwn/nwnx
COPY /nwnx/*.so /nwn/nwnx/
RUN mkdir /etc/gcrypt
RUN echo all >> /etc/gcrypt/hwf.deny
RUN runDeps="hunspell    \
    libmariadb3 \
    libpq-dev   \
    libsqlite3-dev  \
    libruby2.5  \
    luajit  \
    libluajit-5.1   \
    libssl1.1   \
    inotify-tools   \
    patch   \
    dotnet-sdk-3.1" \
    installDeps="ca-certificates wget gpg apt-transport-https"     \
    && apt-get update     \
    && apt-get install -y --fix-missing --no-install-recommends $installDeps     \
    && wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg     \
    && wget -q https://packages.microsoft.com/config/debian/10/prod.list     \
    && mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/     \
    && mv prod.list /etc/apt/sources.list.d/microsoft-prod.list     \
    && apt-get update     \
    && apt-get -y install --fix-missing --no-install-recommends $runDeps     \
    && rm -r /var/cache/apt /var/lib/apt/lists
COPY  /run-server.patch /nwn/
RUN gem install nwn-lib
#RUN patch /nwn/run-server.sh < /nwn/run-server.patch
ENV NWNX_CORE_LOAD_PATH=/nwn/nwnx/
ENV NWN_LD_PRELOAD=/nwn/nwnx/NWNX_Core.so
ENV NWNX_SERVERLOGREDIRECTOR_SKIP=n NWN_TAIL_LOGS=n NWNX_CORE_LOG_LEVEL=6 NWNX_SERVERLOGREDIRECTOR_LOG_LEVEL=6
ENV NWNX_CORE_SKIP_ALL=y
