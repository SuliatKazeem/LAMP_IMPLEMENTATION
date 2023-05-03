#Connecting to EC2 Terminal
sudo chmod 0400 lastbus.pem
ssh -i lastbus.pem ubuntu@54.86.79.134

#Installing Apache and updating the firewall
sudo apt update
sudo apt install apache2
sudo systemctl status apache2

#Installing MySQL
sudo apt install mysql-server
sudo mysql
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'PassWord.1';
mysql> exit
sudo mysql_secure_installation
#This will ask if you want to configure the VALIDATE PASSWORD PLUGIN.Answer Y for yes, or anything else to continue without enabling
# There are three levels of password validation policy:

# LOW    Length >= 8
# MEDIUM Length >= 8, numeric, mixed case, and special characters
# STRONG Length >= 8, numeric, mixed case, special characters and dictionary              file

# Please enter 0 = LOW, 1 = MEDIUM and 2 = STRONG: 1
# Estimated strength of the password: 100 
# Do you wish to continue with the password provided?(Press y|Y for Yes, any other key for No) : y
#For the rest of the questions, press Y and hit the ENTER key at each prompt.

#Installing PHP/Python/Perl
sudo apt install php libapache2-mod-php php-mysql
php -v

#Creating a virtual host for your website using apache 
sudo mkdir /var/www/projectlamp
sudo chown -R $USER:$USER /var/www/projectlamp
sudo vi /etc/apache2/sites-available/projectlamp.conf
   #<VirtualHost *:80>
#     ServerName projectlamp
#     ServerAlias www.projectlamp 
#     ServerAdmin webmaster@localhost
#     DocumentRoot /var/www/projectlamp
#     ErrorLog ${APACHE_LOG_DIR}/error.log
#     CustomLog ${APACHE_LOG_DIR}/access.log combined
# </VirtualHost>
sudo a2ensite projectlamp
sudo a2dissite 000-default
sudo apache2ctl configtest
sudo echo 'Hello LAMP from hostname' $(curl -s http://169.254.169.254/latest/meta-data/public-hostname) 'with public IP' $(curl -s http://169.254.169.254/latest/meta-data/public-ipv4) > /var/www/projectlamp/index.html

#Enable PHP on the website
sudo vim /etc/apache2/mods-enabled/dir.conf
#<IfModule mod_dir.c>
        #Change this:
        #DirectoryIndex index.html index.cgi index.pl index.php index.xhtml index.htm
        #To this:
        #DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm
sudo systemctl reload apache2





