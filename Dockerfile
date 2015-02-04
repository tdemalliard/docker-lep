#####################
### init
FROM tdemalliard/baseimage:0.9.16
MAINTAINER Thibault de Malliard <tdemalliard+docker@gmail.com>

##############################
### install the servers nginx, mariadb, php-fpm
RUN DEBIAN_FRONTEND='noninteractive' \
    apt-get install -qy \
    php5 php5-cli \
    php5-mysql \
    php5-gd \
    php5-fpm \
    nginx

# install mariad
# touch file: avoid bug
RUN mkdir -p /var/lib/mysql && \
    touch /var/lib/mysql/debian-5.5.flag && \
    DEBIAN_FRONTEND='noninteractive' \
    apt-get install -qy \
    mariadb-server

# tweaks for mysql:
RUN mkdir /run/mysqld
RUN chown mysql:root /run/mysqld


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
