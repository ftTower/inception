#!/bin/bash

service mysql start;

# Configurer la base de données et les utilisateurs
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"

# Attendre la fin du processus MySQL si nécessaire
# wait $MYSQL_PID

mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown

exec mysqld_safe