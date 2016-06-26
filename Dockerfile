FROM uofa/apache2-php7-dev

RUN apt update \
&& apt-get -y install software-properties-common apt-transport-https ca-certificates \
&& apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D \
&& echo "deb https://apt.dockerproject.org/repo ubuntu-wily main" > /etc/apt/sources.list.d/docker.list \
&& LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php \
&& apt update \
&& apt-get -y install \
php5.6 php5.6-curl php5.6-gd php5.6-mysql php5.6-mbstring php5.6-xdebug php5.6-xml libapache2-mod-php5.6 \
php7.0 libapache2-mod-php7.0 php-common php-curl php-gd php-curl php-gettext php-gd php-mysql php-memcached \
&& a2dismod php7.0 \
&& a2enmod php5.6 \
&& ln -sfn /usr/bin/php5.6 /etc/alternatives/php \
&& apt-get -y install libedit-dev \
&& apt-get -y autoremove && apt-get -y autoclean && apt-get clean && rm -rf /var/lib/apt/lists /tmp/* /var/tmp/*

RUN echo "sendmail_path = /usr/sbin/ssmtp -t" > /etc/php/5.6/mods-available/sendmail.ini

COPY ./files/xdebug.ini /etc/php/5.6/mods-available/xdebug.ini

# Configure apache modules, php modules, error logging.
RUN phpenmod -v ALL -s ALL curl \
&& phpenmod -v ALL -s ALL sendmail \
&& phpenmod -v ALL -s ALL xdebug
