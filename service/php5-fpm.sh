#!/bin/sh
# from https://github.com/alexex/docker-lamp/blob/master/php-fpm.service
exec /usr/sbin/php5-fpm -c /etc/php5/fpm/ -y /etc/php5/fpm/php-fpm.conf
