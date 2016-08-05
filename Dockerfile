FROM whatwedo/base:latest

ARG SYMFONY__DATABASE__HOST='45.55.48.16'
ENV SYMFONY__DATABASE__HOST ${SYMFONY__DATABASE__HOST}

ARG SYMFONY__DATABASE__PORT=""
ENV SYMFONY__DATABASE__PORT ${SYMFONY__DATABASE__PORT}

ARG SYMFONY__DATABASE__NAME="opcomp"
ENV SYMFONY__DATABASE__NAME ${SYMFONY__DATABASE__NAME}

ARG SYMFONY__DATABASE__USER="opcomp_dev"
ENV SYMFONY__DATABASE__USER ${SYMFONY__DATABASE__USER}

ARG SYMFONY__DATABASE__PASSWORD="0pc0mpPa\$\$w0rD"
ENV SYMFONY__DATABASE__PASSWORD ${SYMFONY__DATABASE__PASSWORD}

ARG SYMFONY__DATABASE__DNS="mysql:dbname=opcomp;host=45.55.48.16"
ENV SYMFONY__DATABASE__DNS ${SYMFONY__DATABASE__DNS}

ARG SYMFONY__SECRET__CODE="4ed508d4c060d98c157850301a7e5c28a29b30ed"
ENV SYMFONY__SECRET__CODE ${SYMFONY__SECRET__CODE}

ARG SYMFONY__REDIS__DSN="redis://198.211.110.146"
ENV SYMFONY__REDIS__DSN ${SYMFONY__REDIS__DSN}

RUN usermod -u 1000 www-data

RUN mkdir /var/www
RUN chown -R www-data /var/www/ && chmod -R 755 /var/www/

RUN add-apt-repository -y ppa:ondrej/php && \
    apt-get update && \
    apt-get install php7.0 php7.0-cli php7.0-common php7.0-cgi php7.0-curl php7.0-imap php7.0-xml php7.0-pgsql php7.0-sqlite3 php7.0-mysql php7.0-fpm php7.0-intl php7.0-gd php7.0-json php7.0-ldap php-memcached php-memcache php-imagick -y && \
    echo "php_flag[expose_php] = Off" >> /etc/php/7.0/fpm/pool.d/www.conf && \
    mkdir -p /run/php

COPY . /var/www/

WORKDIR /var/www

RUN php ./composer.phar install -n && php /var/www/composer.phar dump-autoload

RUN chmod -R 777 /var/www/vendor && chmod -R 777 /var/www/var/cache && chmod -R 777 /var/www/var/logs && \
    chmod -R 777 /var/www/var/sessions
	
#EXPOSE 80
#EXPOSE 443

RUN apt-get autoremove -y && \
    apt-get clean -y && \	