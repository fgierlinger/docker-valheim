#!/bin/bash
LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH
SteamAppId=892970

: ${WORLD:="Valheim"}
: ${SERVERNAME:="Valheim-$(hostname)"}
: ${PORT:=2456}
: ${PUBLIC:=0}
: ${PASSWORD:=""}

if [ ! -z "${PASSWORD}"]; then
    PASSWORD_PARAM="-password \"${PASSWORD}\""
fi

box64 ./valheim_server.x86_64 \
    -batchmode \
    -nographics \
    -savedir /data \
    -public ${PUBLIC} \
    -name "${SERVERNAME}" \
    -world "${WORLD}" \
    -port ${PORT} \
    "${PASSWORD_PARAM:=""}"
