 

Setup LAMP for Centos 7

with multiple instances of PHP-FPM versions



Install Apache 2.4
sudo yum install httpd
Install MySQL/MariaDB
sudo yum install mysql mysql-server
sudo mysql_secure_installation



[optional]
Do not set password to the root user, then always say “no”!

sudo mysql -u root
DROP USER 'root'@'localhost';

CREATE USER 'root'@'%' IDENTIFIED BY '';

GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;

CREATE USER 'root'@'localhost' IDENTIFIED BY '';

GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;

FLUSH PRIVILEGES;
Install the EPEL package repository
sudo yum install epel-release
Install PHP
sudo yum install php
Install PHPMyAdmin
sudo yum install phpmyadmin



[optional]

sudo vim /etc/phpMyAdmin/config.inc.php
> Allow no password login

Go further with PHP-FPM
Remove default PHP handler
sudo vim /etc/httpd/conf.d/php.conf
Add comment “#” to the following lines:

    <FilesMatch \.(php|phar)$>
        SetHandler application/x-httpd-php
    </FilesMatch>
Install the REMI package repository
sudo rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
Install the PHP-FPM package
Eg: with php 7.3, with the most common php extensions (here for Magento 2)



sudo yum --disablerepo=* --enablerepo=remi,remi-safe,remi-php73 install php73 php73-php-fpm php73-php-bcmath php73-php-pdo php73-php-mysqlnd php73-php-opcache php73-php-xml php73-php-mcrypt php73-php-gd php73-php-devel php73-php-mysql php73-php-intl php73-php-mbstring php73-php-bcmath php73-php-json php73-php-iconv php73-php-soap php73-php-zip


Replace “php73” by the version of php of your choice.



sudo vim /etc/opt/remi/php73/php-fpm.d/www.conf
Edit the following values:

user: your user name
group: your group name

listen: 127.0.0.1:9073 where 73 in 9073 is the php version, it’s moer convenient for the next steps and if you want to add php versions

Create the virtual hosts
sudo mkdir /home/web
sudo chown -R <yourUser>:<yourGroup> /home/web/
sudo vim /etc/httpd/conf.d/wildcard73.conf

<VirtualHost *:80>
        ServerName local-php73.com
        ServerAlias *.local-php73.com
        ServerAdmin webmaster@localhost
        VirtualDocumentRoot /home/web/%-3/htdocs
        <Directory /home/web/%-3/htdocs>
                Options FollowSymLinks Multiviews Indexes
                AllowOverride All
                Require all granted
        </Directory>
        ErrorLog /etc/httpd/logs/php73/error.log
        CustomLog /etc/httpd/logs/php73/access.log combined
        LogLevel warn
        <FilesMatch ".+\.ph(p[3457]?|t|tml)$">
                SetHandler "proxy:fcgi://127.0.0.1:9073"
        </FilesMatch>
</VirtualHost>
Add your first host
mkdir /home/web/project-1

mkdir /home/web/project-1/htdocs

sudo vim /etc/hosts

Add the following entry and as much as you have installed php versions:

127.0.0.1 project-1.local-php73.com

Update PHPMyAdmin
[optional]

sudo vim /etc/httpd/conf.d/phpMyAdmin.conf
Set handler for the php-fpm version 7.3

   <FilesMatch ".+\.ph(p[3457]?|t|tml)$">
     SetHandler "proxy:fcgi://127.0.0.1:9073"
   </FilesMatch>

ISSUES WITH SELINUX
//todo

 
