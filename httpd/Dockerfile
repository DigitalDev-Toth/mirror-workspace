FROM mirrorpro/alpine:3.5

MAINTAINER dinosrh <srodriguez@dinosaur.cl>

##
## INSTALL HTTPD
##
ARG HTTPD_PREFIX=/etc/httpd
ARG HTTPD_VERSION=2.4.25
ARG HTTPD_SHA1=bd6d138c31c109297da2346c6e7b93b9283993d2
ENV HTTPD_PREFIX ${HTTPD_PREFIX}
ENV PATH $HTTPD_PREFIX/bin:$PATH
ENV HTTPD_VERSION ${HTTPD_VERSION}
ENV HTTPD_SHA1 ${HTTPD_SHA1}
ENV HTTPD_BZ2_URL https://www.apache.org/dyn/closer.cgi?action=download&filename=httpd/httpd-$HTTPD_VERSION.tar.bz2
ENV HTTPD_ASC_URL https://www.apache.org/dist/httpd/httpd-$HTTPD_VERSION.tar.bz2.asc

WORKDIR $HTTPD_PREFIX

RUN set -x \
  && addgroup -g 82 -S www-data \
  && adduser -u 82 -D -S -G www-data www-data

RUN mkdir -p "$HTTPD_PREFIX" \
  && chown www-data:www-data "$HTTPD_PREFIX"

RUN set -x \
  && runDeps="apr-dev apr-util-dev perl" \
  && apk add --no-cache --virtual .build-deps $runDeps ca-certificates gcc gnupg libc-dev \
    libressl libressl-dev libxml2-dev lua-dev make nghttp2-dev pcre-dev tar zlib-dev nghttp2-libs \
  && wget -O httpd.tar.bz2 "$HTTPD_BZ2_URL" \
  && echo "$HTTPD_SHA1 *httpd.tar.bz2" | sha1sum -c - \
  && wget -O httpd.tar.bz2.asc "$HTTPD_ASC_URL" \
  && export GNUPGHOME="$(mktemp -d)" \
  && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys A93D62ECC3C8EA12DB220EC934EA76E6791485A8 \
  && gpg --batch --verify httpd.tar.bz2.asc httpd.tar.bz2 \
  && rm -r "$GNUPGHOME" httpd.tar.bz2.asc \
  && mkdir -p src \
  && tar -xf httpd.tar.bz2 -C src --strip-components=1 \
  && rm httpd.tar.bz2 \
  && cd src \
  && ./configure --prefix="$HTTPD_PREFIX" \
    --enable-mods-shared=reallyall \
    --with-mpm=event \
    --enable-ssl \
    --enable-so \
    --enable-http2 \
    --disable-lua \
    --disable-authn_dbm \
    --disable-authn_anon \
    --disable-authn_dbd \
    --disable-authz_dbm \
    --disable-authz_owner \
    --disable-authz_dbd \
    --disable-authnz_ldap \
    --disable-authnz_fcgi \
    --disable-authn_core \
    --disable-authz_groupfile \
    --disable-access_compat \
    --disable-auth_form \
    --disable-auth_digest \
    --disable-allowmethods \
    --disable-isapi \
    --disable-socache_dbm \
    --disable-watchdog \
    --disable-macro \
    --disable-dbd \
    --disable-bucketeer \
    --disable-dumpio \
    --disable-echo \
    --disable-example_hooks \
    --disable-case_filter \
    --disable-case_filter_in \
    --disable-example_ipc \
    --disable-buffer \
    --disable-data \
    --disable-ratelimit \
    --disable-reqtimeout \
    --disable-ext_filter \
    --disable-request \
    --disable-include \
    --disable-reflector \
    --disable-substitute \
    --disable-sed \
    --disable-charset_lite \
    --disable-xml2enc \
    --disable-ldap \
    --disable-log_debug \
    --disable-log_forensic \
    --disable-mime_magic \
    --disable-cern_meta \
    --disable-ident \
    --disable-usertrack \
    --disable-unique_id \
    --disable-remoteip \
    --disable-proxy_connect \
    --disable-proxy_ftp \
    --disable-proxy_fcgi \
    --disable-proxy_scgi \
    --disable-proxy_fdpass \
    --disable-proxy_ajp \
    --disable-proxy_express \
    --disable-proxy_hcheck \
    --disable-session \
    --disable-session_cookie \
    --disable-session_crypto \
    --disable-session_dbd \
    --disable-slotmem_shm \
    --disable-slotmem_plain \
    --disable-optional_hook_export \
    --disable-optional_hook_import \
    --disable-optional_fn_import \
    --disable-optional_fn_export \
    --disable-dialup \
    --disable-lbmethod_byrequests \
    --disable-lbmethod_bytraffic \
    --disable-lbmethod_bybusyness \
    --disable-lbmethod_heartbeat \
    --disable-heartbeat \
    --disable-heartmonitor \
    --disable-dav \
    --disable-autoindex \
    --disable-asis \
    --disable-suexec \
    --disable-cgid \
    --disable-cgi \
    --disable-dav_fs \
    --disable-dav_lock \
    --disable-vhost_alias \
    --disable-negotiation \
    --disable-imagemap \
    --disable-actions \
    --disable-speling \
    --disable-userdir \
    --disable-proxy_html \
  && make -j "$(getconf _NPROCESSORS_ONLN)" \
  && make install \
  && cd .. \
  && rm -r src man manual \
  && sed -ri \
    -e 's!^(\s*CustomLog)\s+\S+!\1 /proc/self/fd/1!g' \
    -e 's!^(\s*ErrorLog)\s+\S+!\1 /proc/self/fd/2!g' \
    "$HTTPD_PREFIX/conf/httpd.conf" \
  && runDeps="$runDeps \
    $( \
      scanelf --needed --nobanner --recursive /usr/local \
        | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
        | sort -u \
        | xargs -r apk info --installed \
        | sort -u \
    )" \
  && apk add --virtual .httpd-rundeps $runDeps \
  && apk del .build-deps

##
## HTTPD SETTINGS
##
RUN mkdir -p /var/www \
  && chown www-data:www-data /var/www

RUN mkdir -p /var/cache \
  && chown www-data:www-data /var/cache

RUN mkdir -p /var/cache/httpd \
  && chown www-data:www-data /var/cache/httpd

RUN mkdir -p /var/log \
  && chown www-data:www-data /var/log

RUN mkdir -p /var/log/httpd \
  && chown www-data:www-data /var/log/httpd

COPY httpd-foreground /usr/local/bin/

RUN chmod +x /usr/local/bin/httpd-foreground

ADD httpd.conf /etc/httpd/conf/httpd.conf
ADD extra/httpd-mpm.conf /etc/httpd/conf/extra/httpd-mpm.conf
ADD extra/httpd-connection.conf /etc/httpd/conf/extra/httpd-connection.conf
ADD extra/httpd-cache.conf /etc/httpd/conf/extra/httpd-cache.conf
ADD extra/httpd-vhosts.conf /etc/httpd/conf/extra/httpd-vhosts.conf
ADD extra/httpd-ssl.conf /etc/httpd/conf/extra/httpd-ssl.conf
ADD mirror_pro.cert /etc/httpd/ssl/mirror_pro.cert
ADD mirror_pro.key /etc/httpd/ssl/mirror_pro.key

ENTRYPOINT ["httpd-foreground"]

WORKDIR /var/www/
