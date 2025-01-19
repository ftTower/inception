#!/bin/bash

until mysqladmin ping -h mariadb --silent; do
    echo "Waiting for database..."
    sleep 2
done

wp config create --allow-root \
    --dbname=$SQL_DATABASE \
    --dbuser=$SQL_USER \
    --dbpass=$SQL_PASSWORD \
    --dbhost=mariadb:3306 \
    --path='/var/www/html'

exec php-fpm7.3 --nodaemonize
