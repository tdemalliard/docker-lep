#####################
### init
FROM tdemalliard/baseimage:0.9.16
MAINTAINER Thibault de Malliard <tdemalliard+docker@gmail.com>

# Set correct environment variables.
ENV HOME /root

##############################
### install the servers nginx, mariadb, php-fpm
RUN apt-get install -qy \
    mariadb-server \
    php5 php5-cli \
    php5-mysql \
    php5-gd \
    php5-fpm \
    nginx

#################################
#### install drush 7
# Install composer
RUN \  
    apt-get install -qy curl && \
    curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer
# and drush
RUN \
    composer global require drush/drush:dev-master && \
    ln -sf /root/.composer/vendor/drush/drush/drush /usr/bin/drush

################################
### Set config files and services for autorun
# install custom config files
ADD nginx.conf /etc/nginx/nginx.conf
ADD php-fpm.conf /etc/php5/fpm/php-fpm.conf
ADD www.conf /etc/php5/fpm/pool.d/www.conf

# install service files for runit
ADD mysqld.service /etc/service/mysqld/run
ADD php-fpm.service /etc/service/php-fpm/run
ADD nginx.service /etc/service/nginx/run

################################
### End config
# expose nginx
EXPOSE 80

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
