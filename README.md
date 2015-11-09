LEMP server : linux ubuntu nginx (engine X) mariadb php-fpm

based on tdemalliard\basimage:0.9.17
and ssmtp for emails

````bash
docker build --tag tdemalliard/lemp:latest .
docker tag tdemalliard/lemp:latest tdemalliard/lemp:0.9.17
````