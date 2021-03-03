#!/bin/bash

echo $'\n
alias ll="ls -la"
alias lash="ls -lash"
alias cdvhost="cd /etc/apache2/sites-available/" \n
alias cdwww="cd /var/www" \n
alias addsite="/var/www/create-site.sh" \n
\n
alias startApache="service apache2 start" \n
alias stopApache="service apache2 stop" \n
alias statusApache="service apache2 status" \n
alias restartApache="service apache2 restart" \n
\n
alias startMongo="/opt/mongodb/4.4.3/bin/mongod --config /opt/mongodb/4.4.3/mongod-4.4.3.conf --dbpath ~/database/mongodb/4.4.3" \n
alias stopMongo="/opt/mongodb/4.4.3/bin/mongod --config /opt/mongodb/4.4.3/mongod-4.4.3.conf --dbpath ~/database/mongodb/4.4.3 --shutdown" \n
alias nanoMongo="nano /opt/mongodb/4.4.3/mongod-4.4.3.conf" \n
\n
alias nanoHost="nano /etc/hosts" \n
alias pecl="php -f /usr/bin/pecl" \n
\n
alias tailLog="tail -f /var/log/apache2/access.log" \n
alias tailAccess="tail -f /var/log/apache2/error.log" \n
' >> ~/.bash_profile

export PATH="/opt/mongodb/4.4.3/bin:$PATH"

source ~/.bash_profile

mkdir -p ~/database/mongodb/4.4.3
mkdir -p /var/log/mongodb/ && sudo chmod -R 777 /var/log/mongodb
sudo cp -r /html /var/www

service apache2 start
/opt/mongodb/4.4.3/bin/mongod --config /opt/mongodb/4.4.3/mongod-4.4.3.conf --dbpath ~/database/mongodb/4.4.3
service php7.2-fpm start
service php8.0-fpm start

/bin/bash