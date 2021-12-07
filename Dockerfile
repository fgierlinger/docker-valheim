FROM debian:stable-slim as build

RUN dpkg --add-architecture armhf && apt-get update && apt-get -y install gcc-arm-linux-gnueabihf python3 build-essential cmake ca-certificates git curl && rm -rf /var/lib/apt/lists/*
RUN git clone --branch "v0.2.4" https://github.com/ptitSeb/box86 /box86 && cd /box86 && mkdir build && cd /box86/build && cmake .. -DRPI4ARM64=1 -DCMAKE_BUILD_TYPE=RelWithDebInfo && make -j$(nproc)
RUN git clone --branch "v0.1.6" https://github.com/ptitSeb/box64 /box64 && cd /box64 && mkdir build && cd /box64/build && cmake .. -DRPI4ARM64=1 -DCMAKE_BUILD_TYPE=RelWithDebInfo && make -j$(nproc)
RUN curl -O -L "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" && mkdir /steam && tar -xzf steamcmd_linux.tar.gz -C /steam && rm /steam/linux32/libstdc*

FROM debian:stable-slim
RUN dpkg --add-architecture armhf && apt-get update && apt-get -y install libc6:armhf libstdc++6:armhf libsdl2-2.0-0 ca-certificates && rm -rf /var/lib/apt/lists/*
COPY --from=build /box86/build/box86 /usr/local/bin/box86
COPY --from=build /box86/build/system/box86.conf /etc/binfmt.d/box86
COPY --from=build /box86/x86lib /lib/i386-linux-gnu/
COPY --from=build /box64/build/box64 /usr/local/bin/box64
COPY --from=build /box64/x64lib /lib/x86_64-linux-gnu/
COPY --from=build /box64/build/system/box64.conf /etc/binfmt.d/box64
COPY --from=build /steam/steamcmd.sh /steam/steamcmd.sh
COPY --from=build /steam/linux32/ /steam/linux32/
# Install valheim dedicated server (appid 896660)
RUN DEBUGGER=/usr/local/bin/box86 /steam/steamcmd.sh @sSteamCmdForcePlatformType linux +login anonymous +app_update 896660 +quit
RUN ln -s /steam/linux64/ /root/.steam/sdk64
WORKDIR "/root/Steam/steamapps/common/Valheim dedicated server"
EXPOSE "2456/UDP" "2457/UDP"
COPY entrypoint.sh entrypoint.sh
CMD ["./entrypoint.sh"]
