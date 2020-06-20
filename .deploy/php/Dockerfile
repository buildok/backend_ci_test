FROM ubuntu:18.04

ENV TZ=Europe/Kiev
ENV DEBIAN_FRONTEND=noninteractive
ENV TERM xterm

RUN apt-get update && apt-get -y install \
        apt-transport-https \
        build-essential \
        autoconf \
        automake \
        libtool \
        bison \
        re2c \
        curl \
        nano \
        libgss-dev \
        locales \
        wget \
        locales \
        tzdata \
        graphviz \
        libbz2-dev \
        libgd-dev \
        libpng-dev \
        libjpeg-dev \
        libxml2-dev \
        libssl-dev \
        libcurl4-gnutls-dev \
        libtidy-dev \
        libxslt-dev \
        libsodium-dev \
        libicu-dev \
        libzip-dev \
        libbson-dev \
        uuid-dev \
        zlib1g-dev \
        libonig-dev \
        libsqlite3-dev

RUN apt-get clean

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN locale-gen
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
        && dpkg-reconfigure -f noninteractive tzdata
RUN date

COPY setup.sh /tmp/php/
RUN chmod +x /tmp/php/setup.sh \
        && /tmp/php/setup.sh

COPY conf/www.conf /etc/php/php-fpm.d/

RUN mkdir -p /var/log/php \
        && chmod 777 -R /var/log/php

COPY run.sh /
RUN chmod +x /run.sh

EXPOSE 9000

RUN mkdir /source
RUN chmod -R o+rw /source

CMD ["/run.sh"]
