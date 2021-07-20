#!/bin/bash
set -e

rm /var/www/html/index.html
cp /app/index.html /var/www/html

sed -i 's/default/'"$APACHE_SERVER_NAME"'/' /etc/apache2/sites-available/000-default.conf 


# Arranca el servicio mysql

/etc/init.d/mysql start

exec "$@"

