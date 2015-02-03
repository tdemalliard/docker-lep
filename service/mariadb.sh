#!/bin/sh
exec /usr/bin/mysqld_safe --syslog >> /var/log/mariadb.log 2>&1