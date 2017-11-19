FROM php:7.0-fpm

MAINTAINER Purwandi M <free6300@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true
ENV DISPLAY :20.0
ENV SCREEN_GEOMETRY "2304x1440x24+32"
ENV CHROMEDRIVER_PORT 9515
ENV CHROMEDRIVER_WHITELISTED_IPS ""
ENV CHROMEDRIVER_URL_BASE ""

RUN mkdir /provision
ADD provision /provision
RUN chmod +x /provision/provision.sh
RUN /provision/provision.sh

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install exif gd pdo_pgsql pdo_mysql mbstring zip

RUN curl -fsSL 'https://xdebug.org/files/xdebug-2.5.5.tgz' -o xdebug.tar.gz \
    && mkdir -p xdebug \
    && tar -xf xdebug.tar.gz -C xdebug --strip-components=1 \
    && rm xdebug.tar.gz \
    && ( cd xdebug && phpize && ./configure --enable-xdebug && make -j$(nproc) && make install ) \
    && rm -r xdebug \
    && docker-php-ext-enable xdebug

RUN echo "memory_limit=-1" > $PHP_INI_DIR/conf.d/memory-limit.ini

ADD ./etc/supervisord.conf /etc/
ADD ./etc/supervisor /etc/supervisor
VOLUME [ "/var/log/supervisor" ]

EXPOSE 5900

# ------------------------------------------------------------------------------
# Clean up
# ------------------------------------------------------------------------------

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
