This project sets up a LAMP (Linux, Apache, MySQL, PHP) stack on an AWS EC2 instance running Ubuntu. The setup includes configuring Apache, MySQL, and PHP to serve a dynamic website.

Prerequisites
An AWS account with an EC2 instance running Ubuntu.
A PEM key file for accessing the EC2 instance.
Basic knowledge of Linux command line and AWS.

Steps to Reproduce
1. Connect to EC2 Terminal
First, connect to your EC2 instance via SSH using the PEM key:

sudo chmod 0400 lastbus.pem ssh -i lastbus.pem ubuntu@54.86.79.134

2. Install Apache and Update Firewall
Update your system’s package list and install Apache:

sudo apt update sudo apt install apache2

Check Apache’s status to ensure it is running:

sudo systemctl status apache2

3. Install MySQL
Install the MySQL server:

sudo apt install mysql-server

Secure the MySQL installation and set up the root password:

sudo mysql ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'PassWord.1'; mysql> exit sudo mysql_secure_installation

Configure the password validation plugin. Choose MEDIUM for password strength:

Please enter 0 = LOW, 1 = MEDIUM and 2 = STRONG: 1 Do you wish to continue with the password provided? (y|Y for Yes): y

Answer Y for the rest of the questions to complete the secure installation.

4. Install PHP
Install PHP and the Apache PHP module:

sudo apt install php libapache2-mod-php php-mysql

Check the PHP version to confirm the installation:

php -v

5. Create a Virtual Host for Your Website
Create a directory for your website:

sudo mkdir /var/www/projectlamp sudo chown -R $USER:$USER /var/www/projectlamp

Create a virtual host configuration file for Apache:

sudo vi /etc/apache2/sites-available/projectlamp.conf

Add the following content to the file:

<VirtualHost *:80> ServerName projectlamp ServerAlias www.projectlamp ServerAdmin webmaster@localhost DocumentRoot /var/www/projectlamp ErrorLog ${APACHE_LOG_DIR}/error.log CustomLog ${APACHE_LOG_DIR}/access.log combined </VirtualHost>

Enable the virtual host and disable the default one:

sudo a2ensite projectlamp sudo a2dissite 000-default

Test Apache’s configuration for errors:

sudo apache2ctl configtest

Create a sample HTML file for the website:

sudo echo 'Hello LAMP from hostname' $(curl -s http://****/latest/meta-data/public-hostname) 'with public IP' $(curl -s http://****/latest/meta-data/public-ipv4) > /var/www/projectlamp/index.html

6. Enable PHP on the Website
Edit the Apache dir.conf file to prioritize PHP over other file types:

sudo vim /etc/apache2/mods-enabled/dir.conf

Change the DirectoryIndex line from:

DirectoryIndex index.html index.cgi index.pl index.php index.xhtml index.htm

To:

DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm

Reload Apache to apply the changes:

sudo systemctl reload apache2

Conclusion
There's now a fully functional LAMP stack running on an AWS EC2 instance. This setup includes Apache to serve the website, MySQL for database management, and PHP for dynamic content generation.
