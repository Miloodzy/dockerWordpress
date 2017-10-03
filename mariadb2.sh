#!/bin/sh
mysql_install_db --user mysql > /dev/null

mysqld_safe --user mysql &

sleep 10s

mysql -v < /root/mariadb.sql

sleep 10s

#ps -wef | grep mysql | grep -v grep | awk '{print $2}' | xargs kill -9




