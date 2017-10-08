#!/bin/sh
ipAddress=$1
user=$2
pass=$3
mail=$4

chown -R mysql:mysql /var/lib/mysql
mysql_install_db --user mysql > /dev/null &
sleep 10s
mysqld_safe --user mysql &

sleep 10s

mysql -v < /root/mariadb.sql

sleep 10s

#ps -wef | grep mysql | grep -v grep | awk '{print $2}' | xargs kill -9

mysqld_safe --user mysql &
sleep 5s

echo "FINISHED first"

chown -R mysql:mysql /var/lib/mysql
mysql_install_db --user mysql > /dev/null &
sleep 10s
mysqld_safe --user mysql &

sleep 10s

mysql -v < /root/mariadb.sql

sleep 10s

#ps -wef | grep mysql | grep -v grep | awk '{print $2}' | xargs kill -9

#mysql -v < /root/mariadb2.sql

mysqld_safe --user mysql &
echo "End wordpress request"
sleep 5s

echo "FINISHED SECOND"

echo "creating wordpress folder"
#mkdir /var/www/wordpress

wp --path=/var/www/html/wordpress

echo "make wp-config.php"
wp core config --dbname="wordpress" --dbuser="wordpressuser" --dbpass="password" --path="/var/www/html/wordpress"
wp core install --url="http://$ipAddress/wordpress" --title="Docker Wordpress" --admin_user="$user" --admin_password="$pass" --admin_email="$mail" --path="/var/www/html/wordpress"
#wp core config --dbname=wordpress --dbuser=root --dbpass=root && currentdirectory=${PWD##*/} && password="Annaba00" && wp db create

echo "make install"
#wp core install --url="http://localhost/wordpress" --title="Docker Wordpress" --admin_user="miloud" --admin_password="annaba" --admin_email="miloud.saihia@gmail.com"

#cd /var/www/wordpress
#wp core download
#wget -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 
#chmod +x wp-cli.phar
#mv wp-cli.phar /usr/local/bin/wp
# | bash
#wp core download /var/www/wordpress
#wp core config --dbname=wordpress --dbuser=wordpressuser --dbpass=password
#currentdirectory=${PWD##*/}
#password="annaba"
#wp db create
#wp core instal --url="http://loclalhost/wordpress" --title="Docker Wordpress" --admin_user="miloud" --admin_password="annaba" --admin_email="miloud.saihia@gmail.com"
#echo "END WORDPRESS INSTALL"
