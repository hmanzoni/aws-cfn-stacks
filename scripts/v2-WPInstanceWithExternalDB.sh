#!/bin/bash -xe

## Bring parameter (store in AWS System Manager) values into ENV
## You need create the parameters DBPassword, DBUser, DBName, DBEndpoint
## Using at the beginning /HCM/Wordpress/ in AWS System Manager
DBPassword=$(aws ssm get-parameters --region us-east-1 --names /HCM/Wordpress/DBPassword --with-decryption --query Parameters[0].Value)
DBPassword=`echo $DBPassword | sed -e 's/^"//' -e 's/"$//'`

DBUser=$(aws ssm get-parameters --region us-east-1 --names /HCM/Wordpress/DBUser --query Parameters[0].Value)
DBUser=`echo $DBUser | sed -e 's/^"//' -e 's/"$//'`

DBName=$(aws ssm get-parameters --region us-east-1 --names /HCM/Wordpress/DBName --query Parameters[0].Value)
DBName=`echo $DBName | sed -e 's/^"//' -e 's/"$//'`

DBEndpoint=$(aws ssm get-parameters --region us-east-1 --names /HCM/Wordpress/DBEndpoint --query Parameters[0].Value)
DBEndpoint=`echo $DBEndpoint | sed -e 's/^"//' -e 's/"$//'`

## Update package repositories
yum -y update
yum -y upgrade

## Install pre Requirements and Web Server (mariaDB, php, stress for test)
yum install -y mariadb-server httpd wget
amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
amazon-linux-extras install epel -y
yum install stress -y

## Set up by default start in automatic HTTP Server
systemctl enable httpd
systemctl start httpd

## Download and extract Wordpress
wget http://wordpress.org/latest.tar.gz -P /var/www/html
cd /var/www/html
tar -zxvf latest.tar.gz
cp -rvf wordpress/* .
rm -R wordpress
rm latest.tar.gz

## Configure the wordpress, replace the placeholders from wp-config.php file with values (setup at beginning)
sudo cp ./wp-config-sample.php ./wp-config.php
sed -i "s/'database_name_here'/'$DBName'/g" wp-config.php
sed -i "s/'username_here'/'$DBUser'/g" wp-config.php
sed -i "s/'password_here'/'$DBPassword'/g" wp-config.php
sed -i "s/'localhost'/'$DBEndpoint'/g" wp-config.php

## Improve the security, Fix Permissions on the filesystem
usermod -a -G apache ec2-user   
chown -R ec2-user:apache /var/www
chmod 2775 /var/www
find /var/www -type d -exec chmod 2775 {} \;
find /var/www -type f -exec chmod 0664 {} \;
