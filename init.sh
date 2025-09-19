#!/bin/bash
set -e

cd /var/www/html || exit 1

# Permission fix untuk CI3
chown -R www-data:www-data application/cache application/logs
chmod -R 775 application/cache application/logs

exec php-fpm
