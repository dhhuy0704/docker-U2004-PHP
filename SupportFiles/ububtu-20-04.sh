#!/bin/bash

##
# Add alias for better command line
##
echo $'
alias ll="ls -la"
alias lash="ls -lash"
alias cdvhost="cd /etc/apache2/sites-available/" 
alias cdwww="cd /var/www" 
alias addsite="/var/www/create-site.sh" 
alias configssl="/var/www/config-ssl.sh" 

alias startApache="service apache2 start" 
alias stopApache="service apache2 stop" 
alias statusApache="service apache2 status" 
alias restartApache="service apache2 restart" 

alias startMongo="/opt/mongodb/4.4.3/bin/mongod --config /opt/mongodb/4.4.3/mongod-4.4.3.conf --dbpath ~/database/mongodb/4.4.3" 
alias stopMongo="/opt/mongodb/4.4.3/bin/mongod --config /opt/mongodb/4.4.3/mongod-4.4.3.conf --dbpath ~/database/mongodb/4.4.3 --shutdown"
alias mongorestore="/opt/mongodb/4.4.3/bin/mongorestore"
alias mongodump="/opt/mongodb/4.4.3/bin/mongodump"
alias nanoMongo="nano /opt/mongodb/4.4.3/mongod-4.4.3.conf" 

alias nanoHost="nano /etc/hosts" 
alias pecl="php -f /usr/bin/pecl" 

alias tailLog="tail -f /var/log/apache2/access.log" 
alias tailAccess="tail -f /var/log/apache2/error.log" 
' >> ~/.bash_profile

###
# Add Mongo 4.4.3 is default mongo command
###
export PATH="/opt/mongodb/4.4.3/bin:$PATH"

# Add create mongo data directory and log file
mkdir -p ~/database/mongodb/4.4.3
mkdir -p /var/log/mongodb/ && sudo chmod -R 777 /var/log/mongodb
cp -R mongodb-database-tools-ubuntu2004-x86_64-100.3.0.tgz/bin/* /opt/mongodb/4.4.3/bin

# Copy sample file to Apache default config
sudo cp -r /html /var/www

# Copy auto add site and auto config ssl
cp /create-site.sh /var/www
cp /config-ssl.sh /var/www
sudo chmod 755 /var/www/create-site.sh
sudo chmod 755 /var/www/config-ssl.sh

# Config phantomjs
sudo mv phantomjs-2.1.1-linux-x86_64 /usr/local/share/
sudo ln -sf /usr/local/share/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin

# Start services
/opt/mongodb/4.4.3/bin/mongod --config /opt/mongodb/4.4.3/mongod-4.4.3.conf --dbpath ~/database/mongodb/4.4.3
service apache2 start
service php7.2-fpm start
service php8.0-fpm start

/bin/bash source ~/.bash_profile