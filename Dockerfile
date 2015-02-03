# Dockerizing Drupal sdas

# Format: FROM    repository[:version]
FROM tdemalliard/baseimage:0.9.16

# Format: MAINTAINER Name <email@addr.ess>
MAINTAINER Jujubre <jujubre+docker@gmail.com>

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

#################################
#### isntall nginx
RUN apt-get install -qy python-software-properties
RUN \
    add-apt-repository -y ppa:nginx/stable && \
    apt-get update && \
    apt-get install -qy nginx && \
    echo "\ndaemon off;" >> /etc/nginx/nginx.conf

#### configure nginx for drupal
RUN rm -f /etc/nginx/sites-enabled/*
ADD sites-enabled/* /etc/nginx/sites-enabled/

# ### set the service
RUN mkdir /etc/service/nginx
ADD service/nginx.sh /etc/service/nginx/run

# #################################
# #### Install mariadb
RUN apt-get install -qy mariadb-server
RUN \
    sed -i 's/^\(bind-address\s.*\)/# \1/' /etc/mysql/my.cnf && \
    echo "mysqld_safe --log-error=/var/log/mysql/error.log --skip-syslog &" > /tmp/config && \
    echo "mysqladmin --silent --wait=30 ping || exit 1" >> /tmp/config && \
    echo "mysql -e 'GRANT ALL PRIVILEGES ON *.* TO \"root\"@\"%\" WITH GRANT OPTION;'" >> /tmp/config && \
    bash /tmp/config && \
    rm -f /tmp/config


# ### set the service
RUN mkdir /etc/service/mariadb
ADD service/mariadb.sh /etc/service/mariadb/run

# #################################
# #### Install php5
RUN apt-get install -qy \
    php5-cli \
    php5-fpm \
    php5-mysql \
    php5-gd

# ### set the service
# RUN mkdir /etc/service/mariadb
# ADD service/mariadb.sh /etc/service/mariadb/run

# #################################
# #### drush 7
# # Install composer
# RUN \  
#     apt-get install -qy curl && \
#     curl -sS https://getcomposer.org/installer | php && \
#     mv composer.phar /usr/local/bin/composer
# # and drush
# RUN \
#     composer global require drush/drush:dev-master && \
#     ln -sf /root/.composer/vendor/drush/drush/drush /usr/bin/drush

# #################################
# #### restore sdas
# WORKDIR /tmp

# #################################
# ### cleaning
# # RUN apt-get purge -qy software-properties-common
# # RUN rm -rf /tmp/*
# # RUN apt-get clean -y

# #################################
# #### Define default command.
# CMD ["bash", "init.sh"]

# #################################
# #### Expose ports.
# EXPOSE 80