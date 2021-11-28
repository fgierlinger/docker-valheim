# Dockerized Valheim Server

[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)

This repository provides a Dockerfile to build a containerized valheim server
on Raspberry Pi aarch64. 

## How to use

The server configuration is controlled through environment variables. See
[Configuration](#Configuration) for details about the available parameters. 

	$ docker run -d -p 2456:2456 \
		-e PUBLIC=0 \
		-e NAME="Server name" \
		-e WORLD="WorldName" \
		-e PASSWORD="S3cr3t!" \
		fgierlinger/valheim:latest

All worlds are saved in the container under /data. If the worlds should persist, use a named volume or mount a server volume under /data.

	$ docker run -d -p 2456:2456 -v /opt/valheim:/data fgierlinger/valheim:latest

## Configuration

|| Environment variable || Default value || Description ||
| PUBLIC | 0 | Sets the valheim server visibility to private (0) or public (1) |
| NAME | Valheim-$hostname | Name of the Valheom server. $hostname is replaced at runtime with the container hostname |
| WORLD | ValheimWorld | Name of the Valheim world |
| PASSWORD |  | Password to access the server. If omitted no password is set. |

## Development

If you are interested in contrinbuting to this project feel free to open a pull
request or submit an issue. The commits on this project follow the conventional
commit specification 1.0.0.

## License

MIT

## Author

Frédéric Gierlinger
