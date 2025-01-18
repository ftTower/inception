FROM debian:buster

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    wget \
    php7.3 \
    php7.3-fpm \
    php7.3-mysqli \
    mariadb-client

# Télécharger et installer WordPress
RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www
RUN cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz
RUN mv /var/www/wordpress /var/www/html
RUN chown -R www-data:www-data /var/www/html

# Configurer PHP
COPY conf/php.ini /etc/php/7.3/cli/php.ini

# Télécharger WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

# Copier le script d'initialisation
COPY conf/auto_config.sh /usr/local/bin/script.sh
RUN chmod +x /usr/local/bin/script.sh

CMD ["/usr/local/bin/script.sh"]
