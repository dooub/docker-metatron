#!/bin/bash
source /etc/profile.d/druid.sh
/usr/bin/supervisord -c /usr/local/scripts/all-in-one.conf
