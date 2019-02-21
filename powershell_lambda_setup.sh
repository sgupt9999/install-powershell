#!/bin/bash
# This script will install microsoft repo and then powershell on this machine

# Start of user input
# End of user input

if [[ $EUID != "0" ]]
then
	echo "ERROR. Need to have root privileges to run this script"
	exit 1
else
	echo "This script will install powershell on this machine"
fi

yum update -y
yum install zip -y

echo "Installing Powershell...."
curl https://packages.microsoft.com/config/rhel/7/prod.repo | tee /etc/yum.repos.d/microsoft.repo
yum install powershell -y
echo "Done"

echo "Installing dotnet....."
rpm -Uvh https://packages.microsoft.com/config/rhel/7/packages-microsoft-prod.rpm
yum install dotnet-sdk-2.1 -y
echo "Done"
