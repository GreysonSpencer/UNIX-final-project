#!/bin/bash

# System setup script by Greyson Spencer
# grsncd

# Bucket name where script and alias file are located
BUCKET=3530-init-bucket-gs

echo "Welcome to system setup!"
ID_LIKE=$(cat /etc/*release | grep ID_LIKE)


#
# Admin user setup
#
adduser sysadmin
passwd sysadmin
if [ $ID_LIKE = "ID_LIKE=debian" ]
then
    usermod -a -G sudo sysadmin
elif [ $ID_LIKE = 'ID_LIKE="fedora"' ]
then
    usermod -a -G wheel sysadmin
fi


#
# Alias setup
#
echo "Alias setup:"
wget -P /home/sysadmin https://$BUCKET.s3.amazonaws.com/user-setup/.bash_aliases


#
# OS update
#
if [ $ID_LIKE = "ID_LIKE=debian" ]
then
    apt-get update
elif [ $ID_LIKE = 'ID_LIKE="fedora"' ]
then
    yum update
fi