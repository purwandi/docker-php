FROM php:5.6-fpm

MAINTAINER Purwandi M <free6300@gmail.com>

RUN DEBIAN_FRONTEND=noninteractive \
	apt-get clean && \
    apt-get -q -y update && \
    apt-get -q -y install \
    git zlib1g-dev libfreetype6-dev libjpeg62-turbo-dev libpng12-dev libpq-dev curl

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install gd
RUN docker-php-ext-install pdo_pgsql
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install zip

RUN echo "memory_limit=-1" > $PHP_INI_DIR/conf.d/memory-limit.ini

RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer
