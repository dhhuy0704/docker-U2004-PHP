#!/bin/bash

read -p "Configure SSL for (Ex: jobtraq.local): "  sitename
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

echo "Configure SSL for: $sitename..."

if [ ! -d "/var/www/$sitename" ]; then
    echo "Directory $sitename not found"
    exit 1
fi

if [ ! -f "/etc/apache2/sites-available/${sitename}.conf" ]; then
    echo "Configured $sitename file not found"
    exit 1
fi
echo '
<VirtualHost *:443>
    DocumentRoot /var/www/'$sitename'
    ServerName '$sitename'
    ServerAlias www.'$sitename'
    DirectoryIndex index.php
    SSLEngine on
    SSLCertificateFile "<path>/server.crt"
    SSLCertificateKeyFile "<path>/server.key"
    <Directory /var/www/'$sitename'>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Order allow,deny
        allow from all
    </Directory>
    <FilesMatch \.php$>
        SetHandler "proxy:unix:/run/php/php'$phpver'-fpm.sock|fcgi://localhost"
    </FilesMatch>
</VirtualHost>
' >> /etc/apache2/sites-available/$sitename.conf

echo 'You need to correct path to your key file on server by using: $ nano /etc/apache2/sites-available/'$sitename'.conf'