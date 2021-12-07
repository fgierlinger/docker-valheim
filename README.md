# Dockerized Valheim Server

[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)

This repository provides a Dockerfile to build a containerized valheim server on
Raspberry Pi aarch64. The image is published on docker hub under
fgierlinger/valheim.

## How to use

The server configuration is controlled through environment variables. See
[Configuration](#Configuration) for details about the available parameters. 

        docker run -d -p 2456:2456/udp -p 2457:2457/udp \
            -e PUBLIC=0 \
            -e NAME="Server name" \
            -e WORLD="WorldName" \
            -e PASSWORD="S3cr3t!" \
            fgierlinger/valheim:latest

All worlds are saved under /data. If the worlds should persist, use a named
volume or mount a server volume under /data.

        docker run -d -p 2456:2456/udp -p 2457:2457/udp \
            -v /opt/valheim:/data fgierlinger/valheim:latest

## Configuration


| Environmental variable | Default value | Description |
---|---|---|
PUBLIC | 0 | Sets the valheim server visibility to private (0) or public (1) |
PORT | 2456 | Port in which the Valheim server is running. Both $PORT and $PORT+1 must be accessible (Default 2456 and 2457) |
SERVERNAME | Valheim-$hostname | Name of the Valheom server. $hostname is replaced at runtime with the container hostname |
WORLD | Valheim | Name of the Valheim world |
PASSWORD | | Password to access the server. If omitted no password is set. If ommited, no password is set. |

## Limitations

### Server autodiscovery

Valheim Client uses UDP broadcast messages (255.255.255.255) to query clients in
the local subnet for a valheim server. Docker [does not support forwarding
broadcast messages at the
moment](https://github.com/moby/libnetwork/issues/552). Even when running the
container with network mode host (`--net host`) the broadcast messages are not
received by the container.

Connecting to the server is possible from the Valheim client by using the
_Direct IP_ option in the server browser. Refer to [this guide on how to connect
manually to your
server](https://survivalservers.com/wiki/index.php?title=How_to_Join_a_Valheim_Server).

## Development

If you are interested in contrinbuting to this project feel free to open a pull
request or submit an issue. The commits on this project follow the conventional
commit specification 1.0.0.

## License

MIT

## Author

Frédéric Gierlinger
