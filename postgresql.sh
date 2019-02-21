#!/bin/bash
# Script to install postgreSQL ODBC drivers on RHEL 7+


if [[ $EUID != "0" ]]
then
	echo "ERROR. Need to have root privileges to run this script"
	exit 1
fi

PACKAGE="pgdg-redhat93-9.3-3.noarch.rpm"
DOWNLOAD_LOCATION="https://yum.postgresql.org/9.3/redhat/rhel-7.3-x86_64/pgdg-redhat93-9.3-3.noarch.rpm"
PACKAGE2="postgresql93-odbc postgresql93-odbc-debuginfo"


yum install wget -y -q 
wget $DOWNLOAD_LOCATION
rpm -ivh ./$PACKAGE
yum install -y $PACKAGE2

if [ ! -e /etc/odbcinst.ini.bak ]
then
	cp /etc/odbcinst.ini /etc/odbcinst.ini.bak
fi

echo "[PostgreSQL]" > /etc/odbcinst.ini
echo "Description = ODBC for PostgreSQL" >> /etc/odbcinst.ini
echo "Driver = /usr/pgsql-9.3/lib/psqlodbc.so" >> /etc/odbcinst.ini
echo "Setup = /usr/lib64/libodbcpsqlS.so" >> /etc/odbcinst.ini
echo "FileUsage = 1" >> /etc/odbcinst.ini

echo "Done"

## To test ODBC
## odbcinst -q -d
## odbcinst -j


