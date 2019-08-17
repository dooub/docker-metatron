#!/bin/bash
if [ ! -f "/usr/local/mysql-backup/initvvv" ]; then
    echo "* Add druid user and database to metastore db(i.e. mariadb)"
    mysql -u root -e "CREATE database if not exists druid CHARACTER SET utf8; GRANT ALL ON druid.* TO 'druid'@'localhost' IDENTIFIED BY 'druid';"
    mysql -u root -e "CREATE database if not exists polaris CHARACTER SET utf8; GRANT ALL ON polaris.* TO 'polaris'@'localhost' IDENTIFIED BY 'polaris';"
    mysql -u root -e "CREATE database if not exists polaris_v2 CHARACTER SET utf8; GRANT ALL ON polaris_v2.* TO 'polaris'@'localhost' IDENTIFIED BY 'polaris';GRANT ALL ON polaris_v2.* TO 'polaris'@'%' IDENTIFIED BY 'polaris';"
    echo "Done"
    touch /usr/local/mysql-backup/initvvv
fi
/usr/local/scripts/check-backup.sh
