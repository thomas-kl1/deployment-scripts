
Users:

satis

Setup
Prerequisites
OS: Centos 7
Should have access to internet
Should allow connectivity coming in on port 80 (web server via apache or nginx for satis)
Installation
Satis
sudo yum -y install epel-release
sudo yum -y install nano git htop mlocate wget bind-utils tree # utilities
sudo yum -y install httpd
sudo rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
sudo yum --enablerepo=remi,remi-safe,remi-php73 install php73 php73-php-fpm php73-php-pdo php73-php-mysqlnd php73-php-opcache php73-php-xml php73-php-mcrypt php73-php-gd php73-php-devel php73-php-mysql php73-php-intl php73-php-mbstring php73-php-bcmath php73-php-json php73-php-iconv php73-php-soap php73-php-zip php73-php-posix php73-php-uopz php73-php-libsodium
sudo vim /etc/opt/remi/php73/php-fpm.d/www.conf
Edit the following values:
user: satis
group: satis
listen: 127.0.0.1:9073 # where 73 in 9073 is the php version, it’s more convenient for the next steps and if you want to add php versions
sudo vim /etc/httpd/conf.d/repo.mpbio.com.conf
<VirtualHost *:80>
    ServerName repo.satis.com
    ServerAdmin repo@satis.com
    DocumentRoot /home/satis/archive

    <Directory /home/satis/archive>
        Options FollowSymLinks Multiviews
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog /home/satis/logs/httpd/error.log
    CustomLog /home/satis/logs/httpd/access.log combined
    LogLevel warn
</VirtualHost>

<VirtualHost *:80>
    ServerName satis.com
    ServerAlias *.mpbio.com
    ServerAdmin repo@satis.com
    VirtualDocumentRoot /home/satis/satis/web/%-3/htdocs

    <Directory /home/satis/satis/web/%-3/htdocs>
        Options FollowSymLinks Multiviews Indexes
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog /home/satis/logs/httpd/error.log
    CustomLog /home/satis/logs/httpd/access.log combined
    LogLevel warn

    <FilesMatch ".+\.ph(p[3457]?|t|tml)$">
        SetHandler "proxy:fcgi://127.0.0.1:9073"
    </FilesMatch>
</VirtualHost>
wget https://raw.githubusercontent.com/thomas-kl1/deployment-scripts/master/setup/composer.sh -O - -q > composer.sh
sudo sh composer.sh
su satis
cd ~
mkdir archive
mkdir satis
cd satis
composer create-project composer/satis --stability=dev --keep-vcs
Configuration
https://getcomposer.org/doc/articles/handling-private-packages-with-satis.md#setup
 
