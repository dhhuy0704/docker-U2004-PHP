#!/bin/bash

read -p "Enter site name (Ex: jobtraq.local): "  sitename

if [ -z "${sitename}" ]
then
  echo "Please enter site name !!"
  exit 1
fi

echo "Configurate: $sitename..."

echo "Creating $sitename directory"
if [ -d "/var/www/$sitename" ]; then
  echo "Directory $sitename existed"
  exit 1
fi
sudo mkdir /var/www/$sitename

echo "Set permission..."
sudo chown -R $USER:$USER /var/www/$sitename
sudo chmod -R 755 /var/www/$sitename

echo "Add phpinfo..."
sudo echo "<?php phpinfo(); ?>" > /var/www/$sitename/index.php

echo "Create ${sitename}.conf file"
echo '
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    ServerName '$sitename'
    ServerAlias www.'$sitename'
    DocumentRoot /var/www/'$sitename'
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
' > /etc/apache2/sites-available/$sitename.conf

echo "Check ${sitename}.conf file..."
if sudo apache2ctl configtest
then
	sudo a2ensite $sitename.conf
else
	sudo apache2ctl configtest
fi

service apache2 reload