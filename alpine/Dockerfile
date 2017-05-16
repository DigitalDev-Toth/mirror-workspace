FROM alpine:3.5

MAINTAINER dinosrh <srodriguez@dinosaur.cl>

##
## UPDATE PACKAGE SOURCES
##
RUN apk update

##
## INSTALL COMMON PACKAGES
##
RUN apk add --no-cache git vim

##
## ALPINE SETTINGS
##
ADD profile/alpine_profile.sh /etc/profile
ADD profile/alpine_rc.sh /etc/profile.d/alpine_rc.sh
ADD profile/alpine_alias.sh /etc/profile.d/alpine_alias.sh
ADD profile/alpine_func.sh /etc/profile.d/alpine_func.sh
ADD git/.gitconfig /root/.gitconfig
ADD vim/.vimrc /root/.vimrc
ADD vim/.vim /root/.vim
