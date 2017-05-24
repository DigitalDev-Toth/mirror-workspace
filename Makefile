##
## @name build container command
## @description
##
## Build the named container with its specific tag.
##
## Usage:
## $ make t={TAG} build-{CONTAINER}
## $ make tapn={TAG_ALPINE} thtd={TAG_HTTPD} tngx={TAG_NGINX} tnjs={TAG_NODEJS} \/
## 		tapp={TAG_APPLICATION} build-all
##
## Examples:
## $ make t=3.6 build-alpine
## 		output: docker build -t mirrorpro/alpine:3.6 ./alpine
## $ make build-alpine
## 		output: docker build -t mirrorpro/alpine:3.5 ./alpine
## $ make tapn=3.6 thtd=2.5 tngx=1.14 tnjs=5.1 tapp=0.2 build-all
## 		output:
## 			docker build -t mirrorpro/alpine:3.6 ./alpine
## 			docker build -t mirrorpro/httpd:2.5 ./httpd
## 			docker build -t mirrorpro/nginx:1.14 ./nginx
## 			docker build -t mirrorpro/nodejs:6.11 ./nodejs
## 			docker build -t mirrorpro/application:0.2 ./application
## $ make build-all
## 		output:
## 			docker build -t mirrorpro/alpine:3.5 ./alpine
## 			docker build -t mirrorpro/httpd:2.4 ./httpd
## 			docker build -t mirrorpro/nginx:1.13 ./nginx
## 			docker build -t mirrorpro/nodejs:6.10 ./nodejs
## 			docker build -t mirrorpro/application:0.1 ./application
##
build-%:
	@case "$*" in \
		"alpine") \
			TAG=$(shell [ "$t" != "" ] && echo "$t" || echo "3.5") ;\
			\
			echo "Building container mirrorpro/$*:$$TAG" ;\
			docker build -t mirrorpro/$*:$$TAG ./$* ;;\
		"httpd") \
			TAG=$(shell [ "$t" != "" ] && echo "$t" || echo "2.4") ;\
			\
			echo "Building container mirrorpro/$*:$$TAG" ;\
			docker build -t mirrorpro/$*:$$TAG ./$* ;;\
		"nginx") \
			TAG=$(shell [ "$t" != "" ] && echo "$t" || echo "1.13") ;\
			\
			echo "Building container mirrorpro/$*:$$TAG" ;\
			docker build -t mirrorpro/$*:$$TAG ./$* ;;\
		"nodejs") \
			TAG=$(shell [ "$t" != "" ] && echo "$t" || echo "6.10") ;\
			\
			echo "Building container mirrorpro/$*:$$TAG" ;\
			docker build -t mirrorpro/$*:$$TAG ./$* ;;\
		"application") \
			TAG=$(shell [ "$t" != "" ] && echo "$t" || echo "0.1") ;\
			\
			echo "Building container mirrorpro/$*:$$TAG" ;\
			docker build -t mirrorpro/$*:$$TAG ./$* ;;\
		"all") \
			TAG_ALPINE=$(shell [ "$tapn" != "" ] && echo "$tapn" || echo "3.5") ;\
			TAG_HTTPD=$(shell [ "$thtd" != "" ] && echo "$thtd" || echo "2.4") ;\
			TAG_NGINX=$(shell [ "$tngx" != "" ] && echo "$tngx" || echo "1.13") ;\
			TAG_NODEJS=$(shell [ "$tnjs" != "" ] && echo "$tnjs" || echo "6.10") ;\
			TAG_APPLICATION=$(shell [ "$tapp" != "" ] && echo "$tapp" || echo "0.1") ;\
			\
			echo "Building dinoapi container services" ;\
			docker build -t mirrorpro/alpine:$$TAG_ALPINE ./$* ;\
			docker build -t mirrorpro/httpd:$$TAG_HTTPD ./$* ;\
			docker build -t mirrorpro/nginx:$$TAG_NGINX ./$* ;\
			docker build -t mirrorpro/nodejs:$$TAG_NODEJS ./$* ;\
			docker build -t mirrorpro/application:$$TAG_APPLICATION ./$* ;;\
		*) echo "Container or tag is not valid" ;;\
	esac;

run-%:
	@case "$*" in \
		"alpine") \
			TAG=$(shell [ "$t" != "" ] && echo "$t" || echo "3.5") ;\
			\
			echo "Running container mirrorpro/$*:$$TAG" ;\
			docker kill alpine.mirror-pro.dev 2>/dev/null ;\
			docker run \
			  --name alpine.mirror-pro.dev \
			  -it mirrorpro/$*:$$TAG sh -l ;;\
		"httpd") \
			TAG=$(shell [ "$t" != "" ] && echo "$t" || echo "2.4") ;\
			\
			echo "Running container mirrorpro/$*:$$TAG" ;\
			docker kill httpd.mirror-pro.dev 2>/dev/null ;\
			docker run \
			  --rm \
			  --name httpd.mirror-pro.dev \
			  -p 8038:8038 \
			  -p 8048:8048 \
			  -d mirrorpro/$*:$$TAG ;\
	  	docker exec -it httpd.mirror-pro.dev sh -l ;;\
		"nginx") \
			TAG=$(shell [ "$t" != "" ] && echo "$t" || echo "1.13") ;\
			\
			echo "Running container mirrorpro/$*:$$TAG" ;\
			docker kill nginx.mirror-pro.dev 2>/dev/null ;\
			docker run \
			  --rm \
			  --name nginx.mirror-pro.dev \
			  -p 8018:8018 \
			  -p 8028:8028 \
			  -p 8038:8038 \
			  -p 8048:8048 \
			  -d mirrorpro/$*:$$TAG ;\
		  docker exec -d nginx.mirror-pro.dev /etc/httpd/bin/httpd 2>/dev/null ;\
		  docker exec -it nginx.mirror-pro.dev sh -l ;;\
		"nodejs") \
			TAG=$(shell [ "$t" != "" ] && echo "$t" || echo "6.10") ;\
			\
			echo "Running container mirrorpro/$*:$$TAG" ;\
			docker kill nodejs.mirror-pro.dev 2>/dev/null ;\
			docker run \
			  --rm \
			  --name nodejs.mirror-pro.dev \
			  -p 8018:8018 \
			  -p 8028:8028 \
			  -p 8038:8038 \
			  -p 8048:8048 \
			  -p 8058:8058 \
			  -p 8068:8068 \
			  -dit mirrorpro/$*:$$TAG ;\
		  docker exec -d nodejs.mirror-pro.dev /etc/httpd/bin/httpd 2>/dev/null ;\
		  docker exec -it nodejs.mirror-pro.dev sh -l ;;\
		"application") \
			TAG=$(shell [ "$t" != "" ] && echo "$t" || echo "0.1") ;\
			\
			echo "Running container mirrorpro/$*:$$TAG" ;\
			docker kill application.mirror-pro.dev 2>/dev/null ;\
			docker run \
			  --rm \
			  --name application.mirror-pro.dev \
			  -p 8018:8018 \
			  -p 8028:8028 \
			  -p 8038:8038 \
			  -p 8048:8048 \
			  -p 8058:8058 \
			  -p 8068:8068 \
			  -dit mirrorpro/$*:$$TAG ;\
		  docker exec -d application.mirror-pro.dev /etc/httpd/bin/httpd 2>/dev/null ;\
		  docker exec -it application.mirror-pro.dev sh -l ;;\
		*) echo "Container or tag is not valid" ;;\
	esac;

##
## @name pull image command
## @description
##
## Pull image container service.
##
## Usage:
## $ make t={TAG} pull-{CONTAINER}
## $ make tapn={TAG_ALPINE} thtd={TAG_HTTPD} tngx={TAG_NGINX} tnjs={TAG_NODEJS} \/
## 		tapp={TAG_APPLICATION} pull-all
##
## Examples:
## $ make t=0.2 pull-application
## 		output: docker pull mirrorpro/application:0.2
## $ make pull-application
## 		output: docker pull mirrorpro/application:0.1
## $ make tapn=3.6 thtd=2.5 tngx=1.14 tnjs=6.11 tapp=0.2 pull-all
## 		output:
## 			docker pull -t mirrorpro/alpine:3.6
## 			docker pull -t mirrorpro/httpd:2.5
## 			docker pull -t mirrorpro/nginx:1.14
## 			docker pull -t mirrorpro/nodejs:6.11
## 			docker pull -t mirrorpro/application:0.2
## $ make pull-all
## 		output:
## 			docker pull -t mirrorpro/alpine:3.5
## 			docker pull -t mirrorpro/httpd:2.4
## 			docker pull -t mirrorpro/nginx:1.13
## 			docker pull -t mirrorpro/nodejs:5.0
## 			docker pull -t mirrorpro/application:0.1
##
pull-%:
	@case "$*" in \
		"alpine") \
			TAG=$(shell [ "$t" != "" ] && echo "$t" || echo "3.5") ;\
			\
			echo "Pulling container mirrorpro/$*:$$TAG" ;\
			docker pull mirrorpro/$*:$$TAG ;;\
		"httpd") \
			TAG=$(shell [ "$t" != "" ] && echo "$t" || echo "2.4") ;\
			\
			echo "Pulling container mirrorpro/$*:$$TAG" ;\
			docker pull mirrorpro/$*:$$TAG ;;\
		"nginx") \
			TAG=$(shell [ "$t" != "" ] && echo "$t" || echo "1.13") ;\
			\
			echo "Pulling container mirrorpro/$*:$$TAG" ;\
			docker pull mirrorpro/$*:$$TAG ;;\
		"nodejs") \
			TAG=$(shell [ "$t" != "" ] && echo "$t" || echo "6.10") ;\
			\
			echo "Pulling container mirrorpro/$*:$$TAG" ;\
			docker pull mirrorpro/$*:$$TAG ;;\
		"application") \
			TAG=$(shell [ "$t" != "" ] && echo "$t" || echo "0.1") ;\
			\
			echo "Pulling container mirrorpro/$*:$$TAG" ;\
			docker pull mirrorpro/$*:$$TAG ;;\
		"all") \
			TAG_ALPINE=$(shell [ "$tapn" != "" ] && echo "$tapn" || echo "3.5") ;\
			TAG_HTTPD=$(shell [ "$thtd" != "" ] && echo "$thtd" || echo "2.4") ;\
			TAG_NGINX=$(shell [ "$tngx" != "" ] && echo "$tngx" || echo "1.13") ;\
			TAG_NODEJS=$(shell [ "$tnjs" != "" ] && echo "$tnjs" || echo "6.10") ;\
			TAG_APPLICATION=$(shell [ "$tapp" != "" ] && echo "$tapp" || echo "0.1") ;\
			\
			echo "Pulling dinoapi container services" ;\
			docker pull mirrorpro/alpine:$$TAG_ALPINE ;\
			docker pull mirrorpro/httpd:$$TAG_HTTPD ;\
			docker pull mirrorpro/nginx:$$TAG_NGINX ;\
			docker pull mirrorpro/nodejs:$$TAG_NODEJS ;\
			docker pull mirrorpro/application:$$TAG_APPLICATION ;;\
		*) echo "Container or tag is not valid" ;;\
	esac;

##
## @name push image command
## @description
##
## Push the image container services.
## Make sure to login with dinosaur account to docker
## hub/docker cloud before run this command.
## ** $ docker login
##
## Usage:
## $ make t={TAG} push-{CONTAINER}
## $ make tapn={TAG_ALPINE} thtd={TAG_HTTPD} tngx={TAG_NGINX} tnjs={TAG_NODEJS} \/
## 		tapp={TAG_APPLICATION} push-all
##
## Examples:
## $ make t=0.2 push-application
## 		output: docker push mirrorpro/application:0.2
## $ make push-application
## 		output: docker push mirrorpro/application:0.1
## $ make tapn=3.6 thtd=2.5 tngx=1.14 tnjs=6.11 tapp=0.2 push-all
## 		output:
## 			docker push -t mirrorpro/alpine:3.6
## 			docker push -t mirrorpro/httpd:2.5
## 			docker push -t mirrorpro/nginx:1.14
## 			docker push -t mirrorpro/nodejs:6.11
## 			docker push -t mirrorpro/application:0.2
## $ make push-all
## 		output:
## 			docker push -t mirrorpro/alpine:3.5
## 			docker push -t mirrorpro/httpd:2.4
## 			docker push -t mirrorpro/nginx:1.13
## 			docker push -t mirrorpro/nodejs:6.10
## 			docker push -t mirrorpro/application:0.1
##
push-%:
	@case "$*" in \
		"alpine") \
			TAG=$(shell [ "$t" != "" ] && echo "$t" || echo "3.5") ;\
			\
			echo "Pushing container mirrorpro/$*:$$TAG" ;\
			docker push mirrorpro/$*:$$TAG ;;\
		"httpd") \
			TAG=$(shell [ "$t" != "" ] && echo "$t" || echo "2.4") ;\
			\
			echo "Pushing container mirrorpro/$*:$$TAG" ;\
			docker push mirrorpro/$*:$$TAG ;;\
		"nginx") \
			TAG=$(shell [ "$t" != "" ] && echo "$t" || echo "1.13") ;\
			\
			echo "Pushing container mirrorpro/$*:$$TAG" ;\
			docker push mirrorpro/$*:$$TAG ;;\
		"nodejs") \
			TAG=$(shell [ "$t" != "" ] && echo "$t" || echo "6.10") ;\
			\
			echo "Pushing container mirrorpro/$*:$$TAG" ;\
			docker push mirrorpro/$*:$$TAG ;;\
		"application") \
			TAG=$(shell [ "$t" != "" ] && echo "$t" || echo "0.1") ;\
			\
			echo "Pushing container mirrorpro/$*:$$TAG" ;\
			docker push mirrorpro/$*:$$TAG ;;\
		"all") \
			TAG_ALPINE=$(shell [ "$tapn" != "" ] && echo "$tapn" || echo "3.5") ;\
			TAG_HTTPD=$(shell [ "$thtd" != "" ] && echo "$thtd" || echo "2.4") ;\
			TAG_NGINX=$(shell [ "$tngx" != "" ] && echo "$tngx" || echo "1.13") ;\
			TAG_NODEJS=$(shell [ "$tnjs" != "" ] && echo "$tnjs" || echo "6.10") ;\
			TAG_APPLICATION=$(shell [ "$tapp" != "" ] && echo "$tapp" || echo "0.1") ;\
			\
			echo "Pushing dinoapi container services" ;\
			docker push mirrorpro/alpine:$$TAG_ALPINE ;\
			docker push mirrorpro/httpd:$$TAG_HTTPD ;\
			docker push mirrorpro/nginx:$$TAG_NGINX ;\
			docker push mirrorpro/nodejs:$$TAG_NODEJS ;\
			docker push mirrorpro/application:$$TAG_APPLICATION ;;\
		*) echo "Container or tag is not valid" ;;\
	esac;

##
## @name start container services command
## @description
##
## Start container services.
##
## Usage:
## $ make start-{CONTAINER}
##
## Examples:
## $ make start-application
##
start-%:
	@case "$*" in \
		"app") \
			echo "Starting container $*" ;\
			docker-compose up -d $* ;\
			docker-compose exec -d $* /etc/httpd/bin/httpd ;;\
		*) echo "Container is not valid" ;;\
	esac;

##
## @name shell container services command
## @description
##
## Shell session for container services.
##
## Usage:
## $ make shell-{CONTAINER}
##
## Examples:
## $ make shell-app
##
shell-%:
	@case "$*" in \
		"app") \
			echo "Accesing to shell of container $*" ;\
			docker-compose exec $* sh -l ;;\
		*) echo "Container is not valid" ;;\
	esac;

##
## @name stop container services command
## @description
##
## Stop container services.
##
## Usage:
## $ make stop-{CONTAINER}
##
## Examples:
## $ make stop-application
##
stop-%:
	@case "$*" in \
		"app") \
			echo "Stopping container $*" ;\
			docker-compose stop $* ;;\
		*) echo "Container is not valid" ;;\
	esac;

##
## @name rm all container services command
## @description
##
## Remove/Down all container services.
##
## Usage:
## $ make rm-all
##
rm-all:
	@docker-compose down
