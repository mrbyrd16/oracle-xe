#! /bin/bash

# Install wget
yum install -y wget

# Grabs mysql community RPM
wget https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm

# Installs additional repos
yum local install -y mysql57-community-release-el7-9.noarch.rpm

# Installs mysql server
yum install -y mysql-server

# Get mysql temp pass
TEMP_PW=$(grep 'temporary password' /var/log/mysqld.log|awk '{print$11}')
echo '[client]' >> ./temp_creds
echo "user=root" >> ./temp_creds
echo "password=$TEMP_PW" >> ./temp_creds

# Download sql create db script
curl -o create-wordpress-db.sql https://raw.githubusercontent.com/mrbyrd16/scripts/master/create-wordpress-db.sql

# Login to mysql
mysql --defaults-extra-file=temp_creds < create-wordpress-db.sql

# Install Wordpress pre-reqs
yum install -y httpd
chkconfig --levels 235 httpd on
yum install -y php
yum install -y php-mysql
yum -y install php-gd php-imap php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-mcrypt php-mssql php-snmp php-soap php-tidy curl curl-devel
yum install -y epel-release
wget http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
yum localinstall -y remi-release-7.rpm
yum install -y yum-utils
yum-config-manager --enable remi-php56
yum install php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo

# Install Wordpress
wget http://wordpress.org/latest.tar.gz
tar -zxvf latest.tar.gz
cd wordpress

#download wp-config.php file
curl -o wp-config.php https://raw.githubusercontent.com/mrbyrd16/scripts/master/wp-config.php

cp -r ./* /var/www/html

firewall-cmd --zone=public --add-port=80/tcp --permanent 
firewall-cmd --reload
