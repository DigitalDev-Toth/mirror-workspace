FROM mirrorpro/nodejs:6.10

MAINTAINER dinosrh <srodriguez@dinosaur.cl>

ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LC_CTYPE=UTF-8
ENV LANG=en_US.UTF-8
ENV TERM xterm

##
## INSTALL MAKE
##
RUN apk add --no-cache --virtual .make-deps make

##
## APPLICATION SETTINGS
##
ARG TZ=UTC
ENV TZ ${TZ}

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
  && echo $TZ > /etc/timezone

WORKDIR /var/www

EXPOSE 8188 8288 8388
