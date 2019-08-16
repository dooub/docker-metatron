#!/bin/bash
if [ -d "/usr/local/druid-backup/segments" ]; then
    echo "druid backup exists!!"
    rm -rf /usr/local/druid/var/druid && ln -s /usr/local/druid-backup /usr/local/druid/var/druid
else
    cp -rf /usr/local/druid/var/druid/* /usr/local/druid-backup/
    rm -rf /usr/local/druid/var/druid
    ln -s  /usr/local/druid-backup /usr/local/druid/var/druid
fi
