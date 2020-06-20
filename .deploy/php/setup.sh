#!/bin/bash

mkdir /php-src
cd /php-src

wget -O php.tar.bz2 https://www.php.net/distributions/php-7.4.6.tar.bz2
tar -xvjf php.tar.bz2 --strip-components=1

./configure --prefix=/usr \
    --sysconfdir=/etc/php \
    --disable-cgi \
    --enable-cli \
    --enable-fpm \
    --enable-soap \
    --enable-xml \
    --enable-ftp \
    --enable-sockets \
    --enable-mysqlnd \
    --enable-mbstring \
    --enable-bcmath \
    --enable-calendar \
    --enable-intl \
    --enable-exif \
    --enable-pcntl \
    --enable-gd \
    --with-libxml \
    --with-zip \
    --with-mysqli \
    --with-jpeg \
    --with-freetype \
    --with-xsl \
    --with-gettext \
    --with-tidy \
    --with-openssl \
    --with-mhash \
    --with-curl \
    --with-pdo-mysql \
    --with-bz2 \
    --with-zlib \
    --with-libdir=lib64 \
    --with-config-file-path=/etc/php \
    --with-config-file-scan-dir=/etc/php/conf.d \
    --with-fpm-user=www-data \
    --with-fpm-group=www-data

make -j "$(nproc)" && make install

mkdir -p /etc/php/mods-available
mkdir /etc/php/conf.d
mkdir /etc/php/pool.d

mv php.ini-production /etc/php/php.ini
echo 'error_log=/var/log/php/php_errors.log' >> /etc/php/php.ini

mv /etc/php/php-fpm.conf.default /etc/php/php-fpm.conf

echo 'zend_extension=opcache' > /etc/php/mods-available/opcache.ini
ln -s /etc/php/mods-available/opcache.ini /etc/php/conf.d/opcache.ini

rm -rf /tmp/php
