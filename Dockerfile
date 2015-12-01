#####################
### init
FROM tdemalliard/baseimage:0.9.17.1
MAINTAINER Thibault de Malliard <tdemalliard+docker@gmail.com>

##############################
### install the servers nginx, mariadb, php-fpm
# install php5-fpm and nginx
RUN DEBIAN_FRONTEND='noninteractive' \
    apt-get install -qy \
    php5 php5-cli \
    php5-mysql \
    php5-gd \
    php5-fpm \
    nginx


# install ssmtp
RUN apt-get install -qy \
    ssmtp
ADD ssmtp.conf /etc/ssmtp/ssmtp.conf

################################
### Set config files and services for autorun
# install custom config files
ADD nginx.conf /etc/nginx/nginx.conf
ADD php-fpm.conf /etc/php5/fpm/php-fpm.conf
ADD www.conf /etc/php5/fpm/pool.d/www.conf

# install service files for runit
ADD php-fpm.service /etc/service/php-fpm/run
ADD nginx.service /etc/service/nginx/run

#################################
### cleaning
RUN rm -rf /tmp/* && \
    apt-get clean -y

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

#################################
#### Expose ports.
EXPOSE 80 443