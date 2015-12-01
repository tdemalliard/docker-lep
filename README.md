LEMP server : linux ubuntu nginx (engine X) php-fpm

based on tdemalliard\basimage:0.9.17.1

Emails with ssmtp and relais.rtss.qc.ca mailhub.

````bash
docker build --tag tdemalliard/lep:latest .
docker tag tdemalliard/lep:latest tdemalliard/lep:0.9.17.1
````