/etc/init.d/mysql stop
/usr/sbin/mysqld --skip-grant-tables --skip-networking &
mysql -u root < "FLUSH PRIVILEGES; SET PASSWORD FOR root@'localhost' = PASSWORD('$1'); UPDATE mysql.user SET Password=PASSWORD('$1') WHERE User='root'; FLUSH PRIVILEGES;"
/etc/init.d/mysql stop
/etc/init.d/mysql start