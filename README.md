MIRROR PRO - WORKSPACE
===

REQUIREMENTS
---
- `Docker Engine`
- `Docker Compose`

ENVIRONMENT
---
- `Linux Alpine 3.5`
- `Httpd 2.4.25`
- `Nginx 1.13`
- `NodeJS 6.10.3`

HOW TO USE IT
---
Inside your `mirror-workspace` container services

- Pull `mirror-workspace` environment from docker hub:
```
make pull-app
```
- Start the `mirror-workspace` environment:
```
make start-app
```
- Start shell session for front environment:
```
make shell-app
```
- Stop the `mirror-workspace` environment:
```
make stop-app
```
- Remove the `mirror-workspace` environment:
```
make rm-all
```

WORKING WITH IMAGES
---
Inside your `mirror-workspace` container services

- Build a container service:
```
make t={TAG} build-app
```
- Run a single container service:
```
make t={TAG} run-app
```
- Pull a image from docker hub:
```
make t={TAG} pull-app
```
- Push a image to docker hub:
```
make t={TAG} push-app
```
** all tags are optional


CONTAINER
---
- Bitbucket repository
```
https://github.com/DigitalDev-Toth/mirror-workspace
```
- Docker Hub repository
```
https://hub.docker.com/r/mirrorpro/application
```
- Docker Cloud repository
```
https://cloud.docker.com/swarm/mirrorpro/repository/docker/mirrorpro/application/general
```

TODO
---
- Improve documentation

***
© [Toth](http://www.toth.cl) - all rights reserved
