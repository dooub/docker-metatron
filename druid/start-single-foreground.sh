#!/bin/bash -eu

export METATRON_CONFIG_DIRECTORY=conf
export METATRON_CONFIG_DIRECTORY_ORIGIN=conf_origin

if [[ ! -e ${METATRON_CONFIG_DIRECTORY}/druid ]]; then
    mkdir ${METATRON_CONFIG_DIRECTORY}
    cp -R conf_origin/* conf/
fi

java `cat conf/druid/single/jvm.config | xargs` -cp conf/druid/_common:conf/druid:conf/druid/single:lib/*:/usr/local/Cellar/hadoop/2.7.2/libexec/etc/hadoop io.druid.cli.ServerRunnable $@
