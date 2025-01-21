#!/bin/bash
set -x

until mysqladmin ping -h mariadb --silent; do
    echo "Waiting for database..."
    sleep 2
done


if ! [ -e "/var/www/html/wp-config.php" ] ; then
    wp core download --path=/var/www/html --locale=en_US --allow-root

    wp config create --allow-root \
        --dbname=$SQL_DATABASE \
        --dbuser=$SQL_USER \
        --dbpass=$SQL_PASSWORD \
        --dbhost=mariadb:3306 \
        --path='/var/www/html'

    wp core install \
        --url="tauer.42.fr" \
        --title="OMELETTE DE FROMAGE" \
        --admin_user="$WP_AUSER" \
        --admin_password="$WP_APASS" \
        --admin_email="$WP_AMAIL" \
        --path='/var/www/html' \
        --allow-root
	wp user create "$WP_USER" "$WP_MAIL" \
        --user_pass="$WP_PASS" \
        --path='/var/www/html' \
        --allow-root
fi
mkdir -p /run/php/
exec php-fpm7.4 --nodaemonize
