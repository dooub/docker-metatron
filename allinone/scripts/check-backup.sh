#!/bin/bash
if [ -d "/usr/local/druid-backup/segments" ]; then
    echo "druid backup exists!!"
    if [ -L "/usr/local/druid/var/druid" ]; then
        echo "not writing"
    else
        rm -rf /usr/local/druid/var/druid && ln -s /usr/local/druid-backup /usr/local/druid/var/druid
    fi
else
    cp -rf /usr/local/druid/var/druid/* /usr/local/druid-backup/
    rm -rf /usr/local/druid/var/druid
    ln -s  /usr/local/druid-backup /usr/local/druid/var/druid
fi
