#!/bin/bash

# Démarrer le service MySQL
service mysql start

# Attendre que le socket soit prêt
until mysqladmin ping > /dev/null 2>&1; do
  echo "Attente de MySQL..."
  sleep 1
done

# Créer la base de données, les utilisateurs et configurer les privilèges
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"

# Arrêter MySQL proprement
mysqladmin -u root -p"${SQL_ROOT_PASSWORD}" shutdown
