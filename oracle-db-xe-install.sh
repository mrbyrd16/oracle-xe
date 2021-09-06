#! /bin/bash
#Create log directory
mkdir /xe_logs

# Download preinstall RPM
curl -o oracle-database-preinstall-18c-1.0-1.el7.x86_64.rpm https://yum.oracle.com/repo/OracleLinux/OL7/latest/x86_64/getPackage/oracle-database-preinstall-18c-1.0-1.el7.x86_64.rpm
# Install preinstall RPM
yum -y localinstall oracle-database-preinstall-18c-1.0-1.el7.x86_64.rpm > /xe_logs/XEsilentinstall.log 2>&1
rm -rf oracle-database-preinstall-18c-1.0-1.el7.x86_64.rpm

# Install wget
yum install -y wget

# Download oracle XE install  RPM
wget https://download.oracle.com/otn-pub/otn_software/db-express/oracle-database-xe-18c-1.0-1.x86_64.rpm
# Install oracle XE install RPM
yum -y localinstall oracle-database-xe-18c-1.0-1.x86_64.rpm > /xe_logs/XEsilentinstall.log 2>&1
rm -rf oracle-database-xe-18c-1.0-1.x86_64.rpm

# Configure XE DB
(echo "password"; echo "password";) | /etc/init.d/oracle-xe-18c configure >> /xe_logs/XEsilentinstall.log 2>&1


export ORACLE_SID=XE
export ORACLE_ASK=NO
. oraenv

## Install SQL Plus Client
#curl -o oracle-instantclient-basic-21.3.0.0.0-1.x86_64.rpm https://download.oracle.com/otn_software/linux/instantclient/213000/oracle-instantclient-basic-21.3.0.0.0-1.x86_64.rpm
#yum localinstall -y oracle-instantclient-basic-21.3.0.0.0-1.x86_64.rpm
#curl -o oracle-instantclient-sqlplus-21.3.0.0.0-1.x86_64.rpm https://download.oracle.com/otn_software/linux/instantclient/213000/oracle-instantclient-sqlplus-21.3.0.0.0-1.x86_64.rpm
#yum localinstall -y oracle-instantclient-sqlplus-21.3.0.0.0-1.x86_64.rpm

# Install Oracle APEX
curl -o apex_21.1_en.zip https://download.oracle.com/otn_software/apex/apex_21.1_en.zip
unzip apex_21.1_en.zip

# Change to APEX directory
cd apex

## Enter SQLPlus
#sqlplus /nolol
