Users:

ansistrano
bamboo
Setup
Prerequisites
OS: Centos 7
Should have access to internet
Should have access to stages environments through ssh (QA,Prod) (for rsynk purpose)
Should allow connectivity coming in on port 80 (web server via tomcat for Atlassian Bamboo)
The connectivity on port 80 can be limited to the mpbio VPN
Installation
Ansible
sudo yum -y update
sudo yum -y install epel-release
sudo yum -y install nano git htop mlocate wget bind-utils tree
sudo yum -y install ansible
ansible --version # check ansible installation
python --version # check python installation
Atlassian Bamboo
# Log in as a sudoer user
sudo useradd --create-home --home-dir /home/bamboo --shell /bin/bash bamboo
sudo yum -y install java-1.8.0-openjdk
sudo mkdir -p /opt/atlassian/bamboo/
sudo chown bamboo: /opt/atlassian/bamboo/
sudo su - bamboo
java -version # check java version
update-alternatives --config java # retrieve jre path
vi .bash_profile
export JAVA_HOME=<java bin path>
source .bash_profile
# retrieve the archive then scp to the server (https://www.atlassian.com/software/bamboo/download)
mkdir /home/bamboo/htdocs/
mkdir /home/bamboo/workspace/ # we will storage builds here
cd /opt/atlassian/bamboo/
tar zxvf <archive_name> 
vi /opt/atlassian/bamboo/<bamboo_install_dir>/atlassian-bamboo/WEB-INF/classes/bamboo-init.properties
bamboo.home=/home/bamboo/htdocs
/opt/atlassian/bamboo/<bamboo_install_dir>/bin/start-bamboo.sh
# Log in with as a sudoer user
sudo vi /etc/systemd/system/bamboo.service
[Unit]
Description=Atlassian Bamboo
After=syslog.target network.target

[Service]
Type=forking
User=bamboo
ExecStart=/opt/atlassian/bamboo/<bamboo_install_dir>/bin/start-bamboo.sh
ExecStop=/opt/atlassian/bamboo/<bamboo_install_dir>/bin/stop-bamboo.sh
SuccessExitStatus=143

[Install]
WantedBy=multi-user.target

systemctl enable bamboo.service
MFTF
Install Selenium + Chrome Driver

# https://gist.githubusercontent.com/kaze/eb35d0a815553204cb6d1a9129b20163/raw/be3387796f73e99205f68d701eff056abd496728/selenium-install

#!/usr/bin/env bash
# https://developers.supportbee.com/blog/setting-up-cucumber-to-run-with-Chrome-on-Linux/
# https://gist.github.com/curtismcmullan/7be1a8c1c841a9d8db2c
# http://stackoverflow.com/questions/10792403/how-do-i-get-chrome-working-with-selenium-using-php-webdriver
# http://stackoverflow.com/questions/26133486/how-to-specify-binary-path-for-remote-chromedriver-in-codeception
# http://stackoverflow.com/questions/40262682/how-to-run-selenium-3-x-with-chrome-driver-through-terminal
# http://askubuntu.com/questions/760085/how-do-you-install-google-chrome-on-ubuntu-16-04

# Versions
CHROME_DRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`
SELENIUM_STANDALONE_VERSION=3.8.1
SELENIUM_SUBDIR=$(echo "$SELENIUM_STANDALONE_VERSION" | cut -d"." -f-2)

# Make sure you have below info in the yum repo file.
cat >/etc/yum.repos.d/google-chrome.repo <<EOL
[google-chrome]
name=google-chrome
baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
EOL

# Remove existing downloads and binaries so we can start from scratch.
yum remove google-chrome-stable
rm ~/selenium-server-standalone-*.jar
rm ~/chromedriver_linux64.zip
rm /usr/local/bin/chromedriver
rm /usr/local/bin/selenium-server-standalone.jar

# Install dependencies.
yum update
yum install -y unzip openjdk-8-jre-headless xorg-x11-server-Xvfb libXi-devel GConf2-devel google-chrome

# Install ChromeDriver.
wget -N https://chromedriver.storage.googleapis.com/2.35/chromedriver_linux64.zip -P ~/
unzip ~/chromedriver_linux64.zip -d ~/
rm ~/chromedriver_linux64.zip
mv -f ~/chromedriver /usr/local/bin/chromedriver
chown root:root /usr/local/bin/chromedriver
chmod 0755 /usr/local/bin/chromedriver

# Install Selenium.
wget -N http://selenium-release.storage.googleapis.com/$SELENIUM_SUBDIR/selenium-server-standalone-$SELENIUM_STANDALONE_VERSION.jar -P ~/
mv -f ~/selenium-server-standalone-$SELENIUM_STANDALONE_VERSION.jar /usr/local/bin/selenium-server-standalone.jar
chown root:root /usr/local/bin/selenium-server-standalone.jar
chmod 0755 /usr/local/bin/selenium-server-standalone.jar

Other tools
composer <wip>
phpqa <wip>
Configuration
Register a new server in ansible, eg the server we want to register is: 192.168.1.142

vi /etc/ansible/hosts
192.168.1.142
ssh-keygen -t rsa -b 2048
copy-paste the public key to the server dist
Settings Plans


 
