#!/bin/bash

read -p "Enter site name (Ex: jobtraq.local): "  sitename
read -p "Which PHP version (Input: 8.0, 7.2...)? "  phpver

if [ -z "${sitename}" ]
then
  echo "Please enter site name !!"
  exit 1
fi

if [ -z "${phpver}" ]
then
  echo "Which PHP version (Input: 8.0, 7.2...)!!"
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
    ServerAdmin admin@'$sitename'
    ServerName '$sitename'
    ServerAlias www.'$sitename'
    DocumentRoot /var/www/'$sitename'
    	<Directory /var/www/'$sitename'>
	        Options Indexes FollowSymLinks MultiViews
	        AllowOverride All
	        Order allow,deny
	        allow from all
	    </Directory>
	    <FilesMatch \.php$>
        	SetHandler "proxy:unix:/run/php/php'$phpver'-fpm.sock|fcgi://localhost"
	    </FilesMatch>
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