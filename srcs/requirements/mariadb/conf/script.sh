#!/bin/bash

chown mysql -R /var/lib/mysql
mkdir -p /var/run/mysqld/
chown mysql -R /var/run/mysqld
mysql_upgrade --user=mysql --datadir=/var/lib/mysql

service mariadb start;

mysqladmin status --wait

# Configurer la base de données et les utilisateurs
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';"
mysql -e "FLUSH PRIVILEGES;"

# Attendre la fin du processus MySQL si nécessaire
# wait $MYSQL_PID

service mariadb stop;
exec mysqld_safe