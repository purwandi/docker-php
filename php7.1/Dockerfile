FROM php:7.1-fpm

MAINTAINER Purwandi M <free6300@gmail.com>

RUN rm -f /etc/apt/sources.list && touch /etc/apt/sources.list
RUN echo 'deb http://kambing.ui.ac.id/debian/ jessie main' >> /etc/apt/sources.list
RUN echo 'deb-src http://kambing.ui.ac.id/debian/ jessie main' >> /etc/apt/sources.list
RUN echo 'deb http://security.debian.org/ jessie/updates main' >> /etc/apt/sources.list
RUN echo 'deb-src http://security.debian.org/ jessie/updates main' >> /etc/apt/sources.list
RUN echo 'deb http://kambing.ui.ac.id/debian/ jessie-updates main' >> /etc/apt/sources.list
RUN echo 'deb-src http://kambing.ui.ac.id/debian/ jessie-updates main' >> /etc/apt/sources.list

RUN DEBIAN_FRONTEND=noninteractive \
	apt-get clean && \
    apt-get -q -y update && \
    apt-get -q -y install \
    git zlib1g-dev libfreetype6-dev libjpeg62-turbo-dev libpng12-dev libpq-dev curl wget unzip tar bzip2

## INSTALL JAVA
RUN apt-get install default-jre -y

## DISPLAY
RUN apt-get install xvfb -y

## CHROME REQUIREMENT DEBIAN
RUN apt-get install libdbusmenu-glib4 libdbusmenu-gtk4 libxft2 libpango1.0-0 libxss1 fonts-liberation libindicator7 libpangoxft-1.0-0  libappindicator1 xdg-utils libpangox-1.0-0 -y

## CHROME REQUIREMENT UBUNTU
# RUN apt-get install libpango1.0-0 libxss1 fonts-liberation libindicator7 libpangoxft-1.0-0  libappindicator1 xdg-utils libpangox-1.0-0 -y

## INSTALL FIREFOX
RUN wget https://ftp.mozilla.org/pub/firefox/releases/45.2.0esr/linux-x86_64/en-US/firefox-45.2.0esr.tar.bz2
RUN tar xvjf firefox-45.2.0esr.tar.bz2 -C /opt
RUN ls /opt/firefox
RUN ln -s /opt/firefox/firefox /usr/bin/firefox
RUN chmod 755 /usr/bin/firefox

## INSTALL CHROME
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome-stable_current_amd64.deb

## INSTALL CHROME WEB DRIVER
RUN wget http://chromedriver.storage.googleapis.com/2.23/chromedriver_linux64.zip
RUN unzip chromedriver_linux64.zip
RUN mv chromedriver /usr/local/bin/
RUN chmod 755 /usr/local/bin/chromedriver

RUN echo '127.0.0.1 tixton.app' >> /etc/hosts
RUN echo '127.0.0.1 tixton.dev' >> /etc/hosts

## SET
RUN Xvfb :99 -ac &
RUN export DISPLAY=:99

## DOWNLOADING SELENIUM
RUN wget http://selenium-release.storage.googleapis.com/2.53/selenium-server-standalone-2.53.1.jar && mv selenium-server-standalone-2.53.1.jar /usr/local/bin/selenium-server-standalone-2.53.1.jar

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install gd
RUN docker-php-ext-install pdo_pgsql
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install zip

RUN echo "memory_limit=-1" > $PHP_INI_DIR/conf.d/memory-limit.ini

RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer
