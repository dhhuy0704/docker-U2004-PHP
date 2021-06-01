FROM ubuntu:20.04

LABEL maintainer="TommyDo"
LABEL email="tommy@anvydigital.com"
LABEL version="1.0"
LABEL description="Environment for all Anvy Digital projects"

#########################
## START EDITABLE ZONE ##
#########################

# SET ENV VAR 
ENV PROJECT_NAME AnvyDevEnv
ENV MONGODB_VER 4.4.3

# PATHS

# CONFIGURATIONS
ENV PHP_UPLOAD_MAX_FILESIZE 128M
## -1 is unlimited, specific number is the number limited, ex: 512MB, 2GB
ENV MEMORY_LIMIT -1
ENV PHP_POST_MAX_SIZE 128M
ENV MAX_EXECUTION_TIME 3600
ENV PHP_TIMEZONE "America\/Edmonton"

# PORTS
EXPOSE 80/tcp
EXPOSE 81/tcp
EXPOSE 443/tcp
EXPOSE 25/tcp
EXPOSE 27017/tcp
EXPOSE 27018/tcp

#######################
## END EDITABLE ZONE ##
#######################

# Install needed packages
RUN apt-get update && apt-get -y install sudo
RUN apt -y install nano vim wget git unzip net-tools ufw curl iputils-ping
RUN DEBIAN_FRONTEND='noninteractive' apt -y install build-essential chrpath libssl-dev libxft-dev

# Install with skipping prompt input
RUN DEBIAN_FRONTEND='noninteractive' apt -y install php-pear

# Install Server
# https://www.digitalocean.com/community/tutorials/how-to-install-the-apache-web-server-on-ubuntu-20-04
RUN sudo apt install -y apache2
RUN sudo ufw allow 'Apache'
RUN echo 'ServerName localhost' >> /etc/apache2/apache2.conf
RUN sudo a2enmod rewrite
RUN sudo a2enmod ssl

# Install multi PHP version
# https://www.digitalocean.com/community/tutorials/how-to-run-multiple-php-versions-on-one-server-using-apache-and-php-fpm-on-ubuntu-20-04
RUN sudo apt-get install software-properties-common -y
RUN sudo add-apt-repository ppa:ondrej/php
RUN sudo apt-get update -y

RUN sudo apt-get install -y libapache2-mod-fcgid
RUN sudo apt-get install php7.2 php7.2-fpm libapache2-mod-php7.2 php7.2-mongodb php7.2-xml php7.2-curl -y
RUN sudo apt-get install php8.0 php8.0-fpm libapache2-mod-php8.0 php8.0-mongodb -y

RUN sudo a2enmod actions fcgid alias proxy_fcgi

COPY SupportFiles/MongoDB/mongod-4.4.3.conf /

RUN curl -O https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-ubuntu2004-4.4.3.tgz 
RUN tar -zxvf mongodb-linux-x86_64-ubuntu2004-4.4.3.tgz
RUN mv mongodb-linux-x86_64-ubuntu2004-4.4.3 4.4.3
RUN mkdir -p /opt/mongodb
RUN cp -r /4.4.3 /opt/mongodb

RUN curl -O https://fastdl.mongodb.org/tools/db/mongodb-database-tools-ubuntu2004-x86_64-100.3.0.tgz
RUN tar -zxvf mongodb-database-tools-ubuntu2004-x86_64-100.3.0.tgz

RUN cp /mongod-4.4.3.conf /opt/mongodb/4.4.3
RUN export PATH=/opt/mongodb/4.4.3/bin:$PATH

COPY SupportFiles/HOW_TO_SETUP_DOMAIN.txt /
RUN cp /HOW_TO_SETUP_DOMAIN.txt /var/www

RUN curl -O https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2
RUN sudo tar -zxvf phantomjs-2.1.1-linux-x86_64.tar.bz2

ADD SupportFiles/create-site.sh /
ADD SupportFiles/config-ssl.sh /
ADD SupportFiles/html /html

# Trick to fix error cannot set permission
RUN usermod -u 1000 www-data
RUN usermod -G staff www-data

# Start up services when run container
COPY SupportFiles/ububtu-20-04.sh /
ENTRYPOINT ["/ububtu-20-04.sh"]
## DON'T ADD MORE COMMANDS AFTER THIS LINE