#!/bin/bash
# Script to install unixODBC on Centos/RHEL 7+


if [[ $EUID != "0" ]]
then
	echo "ERROR. Need to have root privileges to run this script"
	exit 1
fi

PACKAGES="unixODBC"

echo "Installing unixODBC......."
yum install -y -q $PACKAGES
echo "Done"


