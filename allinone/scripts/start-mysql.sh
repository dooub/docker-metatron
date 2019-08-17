#!/bin/bash
if [ -d "/usr/local/mysql-backup/mysql" ]; then
    echo "mysql data exists!!"
    if [ -L "/var/lib/mysql" ]; then
        echo "not writing"
        rm -rf /var/lib/mysql/mysql.sock
        rm -rf /var/lib/mysql/mysql.sock.lock
    else
        rm -rf /var/lib/mysql && mkdir -p /var/lib/mysql
#        /usr/sbin/mysqld --initialize-insecure --datadir=/var/lib/mysql --user=root
        ln -s /usr/local/mysql-backup /var/lib/mysql
        rm -rf /var/lib/mysql/mysql.sock
        rm -rf /var/lib/mysql/mysql.sock.lock
        echo "explicit_defaults_for_timestamp = 1" >> /etc/my.cnf
        echo "collation-server = utf8_unicode_ci" >> /etc/my.cnf
        echo "character-set-server = utf8" >> /etc/my.cnf
        echo "skip-character-set-client-handshake" >> /etc/my.cnf
        date > /usr/local/mysql-backup/version
    fi
    /usr/sbin/mysqld --user=root
else
    echo "mysql data doesn't exists!!"
    rm -rf /usr/local/mysql-backup/* && rm -rf /var/lib/mysql
    ln -s /usr/local/mysql-backup /var/lib/mysql
    /usr/sbin/mysqld --initialize-insecure --datadir=/var/lib/mysql --user=root
    echo "explicit_defaults_for_timestamp = 1" >> /etc/my.cnf
    echo "collation-server = utf8_unicode_ci" >> /etc/my.cnf
    echo "character-set-server = utf8" >> /etc/my.cnf
    echo "skip-character-set-client-handshake" >> /etc/my.cnf
    /usr/sbin/mysqld --user=root
fi
