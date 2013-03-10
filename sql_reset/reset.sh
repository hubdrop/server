/etc/init.d/mysql stop
/usr/sbin/mysqld --skip-grant-tables --skip-networking &
mysql -u root < reset.sql
/etc/init.d/mysql stop
/etc/init.d/mysql start