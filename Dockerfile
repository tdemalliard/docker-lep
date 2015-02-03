FROM tdemalliard/baseimage:0.9.16
MAINTAINER Thibault de Malliard <tdemalliard+docker@gmail.com>

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# install the servers
RUN apt-get install -qy \
    mariadb-server \
    php5 php5-cli \
    php5-mysql \
    php5-gd \
    php5-fpm \
    nginx

# install custom config files
ADD nginx.conf /etc/nginx/nginx.conf
ADD php-fpm.conf /etc/php5/fpm/php-fpm.conf
ADD www.conf /etc/php5/fpm/pool.d/www.conf

# install service files for runit
ADD mysqld.service /etc/service/mysqld/run
ADD php-fpm.service /etc/service/php-fpm/run
ADD nginx.service /etc/service/nginx/run

# # add socket directory for php-fpm
# RUN mkdir -p /run/fpm

# expose nginx
EXPOSE 80

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
