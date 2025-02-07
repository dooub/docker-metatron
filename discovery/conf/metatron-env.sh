#!/bin/bash

# export JAVA_HOME=
# export METATRON_JAVA_OPTS      		# Additional jvm options. for example, export METATRON_JAVA_OPTS="-Dspark.executor.memory=8g -Dspark.cores.max=16"
export METATRON_MEM="-Xms16g -Xmx16g -XX:MaxPermSize=1g"            		# metatron jvm mem options Default -Xms1024m -Xmx1024m -XX:MaxPermSize=512m

# export METATRON_ENV_MODE              # ENV mode, profile mode, default local
# export METATRON_EXTRA_PROFILE         # Extra profile, comma seperated
# export METATRON_LOG_DIR        		# Where log files are stored.  PWD by default.
# export METATRON_PID_DIR        		# The pid files are stored. ${METATRON_HOME}/run by default.
# export METATRON_IDENT_STRING   		# A string representing this instance of zeppelin. $USER by default.
# export METATRON_NICENESS       		# The scheduling priority for daemons. Defaults to 0.
# export $METATRON_CLASSPATH_OVERRIDES  # additional classpath

# export METATRON_DB_TYPE               # h2 or mysql. h2 by default
# export METATRON_H2_DATA_DIR           # h2 db data directory
# export METATRON_INDEX_DIR             # lucene index directory
