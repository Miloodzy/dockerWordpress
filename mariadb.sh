#!/bin/sh
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

