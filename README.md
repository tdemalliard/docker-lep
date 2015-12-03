LEP server : linux ubuntu nginx (engine X) php-fpm

**no MySQL server** : use MySQL container

based on tdemalliard\basimage:0.9.17.1

Emails with ssmtp and relais.rtss.qc.ca mailhub. SSMTP is compatible with gmail, google it.

````bash
docker build --tag tdemalliard/lep .
docker tag tdemalliard/lep:latest tdemalliard/lep:0.9.17.1
````