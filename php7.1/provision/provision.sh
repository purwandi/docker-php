#!/bin/bash
# ------------------------------------------------------------------------------
# Provisioning script for the docker-laravel image
# ------------------------------------------------------------------------------

apt-get clean
apt-get -q -y update
apt-get -q -y install git zlib1g-dev libfreetype6-dev libjpeg62-turbo-dev libpng12-dev \
libpq-dev curl wget unzip tar bzip2

# ------------------------------------------------------------------------------
# Composer PHP dependency manager
# ------------------------------------------------------------------------------

curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

# ------------------------------------------------------------------------------
# Node and npm
# ------------------------------------------------------------------------------

curl -sL https://deb.nodesource.com/setup_6.x | bash -
apt-get -y install nodejs

# Chrome

useradd automation --shell /bin/bash --create-home
apt-get -yqq install libdbusmenu-glib4 libdbusmenu-gtk4 libxft2 libpango1.0-0 libxss1 fonts-liberation libindicator7 libpangoxft-1.0-0  libappindicator1 xdg-utils libpangox-1.0-0 -y
apt-get -yqq install xvfb tinywm supervisor vim
apt-get -yqq install fonts-ipafont-gothic xfonts-cyrillic xfonts-100dpi xfonts-75dpi xfonts-base xfonts-scalable

CHROMEDRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`
mkdir -p /opt/chromedriver-$CHROMEDRIVER_VERSION && \
curl -sS -o /tmp/chromedriver_linux64.zip http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip && \
unzip -qq /tmp/chromedriver_linux64.zip -d /opt/chromedriver-$CHROMEDRIVER_VERSION && \
rm /tmp/chromedriver_linux64.zip && \
chmod +x /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver && \
ln -fs /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver /usr/local/bin/chromedriver


curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list && \
    apt-get -yqq update && \
    apt-get -yqq install google-chrome-stable x11vnc ca-certificates

# vnc

VNC_STORE_PWD_FILE=/home/automation/.vnc/passwd
if [ ! -e "${VNC_STORE_PWD_FILE}" -o -n "${VNC_PASSWORD}" ]; then
    mkdir -vp /home/automation/.vnc
    # the default VNC password is 'hola'
    x11vnc -storepasswd ${VNC_PASSWORD:-hola} ${VNC_STORE_PWD_FILE}
    chown -R automation /home/automation
fi

# ------------------------------------------------------------------------------
# Clean up
# ------------------------------------------------------------------------------
rm -rf /provision