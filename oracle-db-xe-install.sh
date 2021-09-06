#! /bin/bash

# Download preinstall RPM
curl -o oracle-database-preinstall-18c-1.0-1.el7.x86_64.rpm https://yum.oracle.com/repo/OracleLinux/OL7/latest/x86_64/getPackage/oracle-database-preinstall-18c-1.0-1.el7.x86_64.rpm
# Install preinstall RPM
yum -y localinstall oracle-database-preinstall-18c-1.0-1.el7.x86_64.rpm > /xe_logs/XEsilentinstall.log 2>&1

# Download oracle XE install  RPM
wget https://download.oracle.com/otn-pub/otn_software/db-express/oracle-database-xe-18c-1.0-1.x86_64.rpm
# Install oracle XE install RPM
yum -y localinstall oracle-database-xe-18c-1.0-1.x86_64.rpm > /xe_logs/XEsilentinstall.log 2>&1

# Remove RPM files
rm oracle-database-preinstall-18c-1.0-1.el7.x86_64.rpm
rm oracle-database-xe-18c-1.0-1.x86_64.rpm

# Configure XE DB
(echo "password"; echo "password";) | /etc/init.d/oracle-xe-18c configure >> /xe_logs/XEsilentinstall.log 2>&1
