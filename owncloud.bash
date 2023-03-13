#!/bin/bash    

showMe(){
 echo "@@@@@@@@@@@@@@@@@@@@@@B?!JJ55#@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@G!^~J!?#@@@@@@@@@@@@@@@@@@@
@@@@@@@&#BBBBBB#&@@@5!7?777J@@@#BBB#BB##&@@@@@@@
@@@@&#BGGGBBPPPGG&@#7?!77!77#@GBPPPBBBGGBB&@@@@@
@&&#BGGGGGBBPPPBB&@YJ??J?J??G@BBGPPBBBGGGGB##&@@
@@#BBGGGGGGBGGG#B&#GGGGGGGGGG&##GGGBGGGGGGBB#@@@
@##BGGGGGGGGBBBB#&B55PPPPPP5G&#BBBBBGGGGGGGB##@@
@@&BGGGGGGGGBBBBBPYPB@@@@@#PYPBBBBBGGGGGGGGB#@@@
@@#BBGGGGGGGGG#BY5PPB@@@@@#PG5YB#BPGGGGGGGBB#@@@
@@&&BBGGGGGGGGGGYGPPB@&P#@#PPG55GGPGGGGGGGB##@@@
@@@&BBGGGGGBGBGBYGPPB@@#&@#PPG5PBBGBGGGGGGB&@@@@
@@@&#BBGGBGBBBB@YPPPB@@&@@#PPGY&#BBBBBGGGG##@@@@
@@@@#BBBBBBB##@@GYGPB@&P#@#PG5P@@##BBBBBBBB@@@@@
@@@&BBBBBB#&@&##&G5PB@@@@@#P5P&&##@&#B#BBBB&@@@@
@@@#BB#B##@@@#5PB&B5P&@@@&GYG&#PPG@@@&#B#B#B@@@@
@@#BB###@@@@@@BPPPGBG5PGP5PBBPPPG@@@@@@&B#B##@@@
@&####&@@@@&BPY5PP5PPBGPGGPP5PP5J5B&@@@@&#####@@
&###@@@@@@@&GJYJY555PYB?G55PP55JYY5#@@@@@@@&##&@
#&@@@@@@@@@@@@BGYJ5J5P5?YP5YYYJGB&@@@@@@@@@@@@#&
@@@@@@@@@@@@@@@@&@BG#BGBGG#GG&&@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
"
}

showMe

sudo apt update && sudo apt upgrade
sudo apt install apache2
sudo systemctl enable --now apache2
sudo add-apt-repository ppa:ondrej/php --yes &> /dev/null
sudo apt update
sudo apt install php7.4 php7.4-{opcache,gd,curl,mysqlnd,intl,json,ldap,mbstring,mysqlnd,xml,zip} -y
sudo apt-get install mysql-server-8.0
mysql --password=Root@123 --user=root --host=localhost << eof
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password by '1234';
CREATE DATABASE owncloud;
CREATE USER 'taufique'@'localhost' IDENTIFIED BY 'Root@123';
GRANT ALL PRIVILEGES ON owncloud.* TO 'taufique'@'localhost';
FLUSH PRIVILEGES;
exit;
eof
cd /tmp
wget https://download.owncloud.com/server/stable/owncloud-complete-latest.tar.bz2
tar -xvf owncloud-complete-latest.tar.bz2
sudo mv owncloud /var/www/html/
sudo chown -R www-data: /var/www/html/owncloud
cat > /etc/apache2/sites-available/owncloud.conf << 'EOL'
<VirtualHost \*:80>

ServerAdmin admin@example.com
DocumentRoot /var/www/html/owncloud
ServerName example.com

<Directory /var/www/html/owncloud>
Options FollowSymlinks
AllowOverride All
Require all granted
</Directory>

ErrorLog ${APACHE_LOG_DIR}/example.com_error.log
CustomLog ${APACHE_LOG_DIR}/your-domain.com_access.log combined

</VirtualHost>
EOL

