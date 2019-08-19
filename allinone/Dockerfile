FROM centos:7

RUN TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` &&     curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.rpm" > tini.rpm &&     rpm -Uvh tini.rpm &&     rm tini.rpm
RUN yum -y update   && yum clean all   && yum update -y libselinux   && yum -y install systemd
RUN yum clean all;   (cd /lib/systemd/system/sysinit.target.wants/;   for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done);   rm -f /lib/systemd/system/multi-user.target.wants/*;   rm -f /etc/systemd/system/*.wants/*;   rm -f /lib/systemd/system/local-fs.target.wants/*;   rm -f /lib/systemd/system/sockets.target.wants/*udev*;   rm -f /lib/systemd/system/sockets.target.wants/*initctl*;   rm -f /lib/systemd/system/basic.target.wants/*;  rm -f /lib/systemd/system/anaconda.target.wants/*;

RUN yum install -y epel-release
RUN rpm -ivh https://dev.mysql.com/get/mysql57-community-release-el7-10.noarch.rpm
RUN yum install -y telnet vim rdate rsync cronie net-tools wget curl tar git jq sudo which less tmux htop iptables-services openssh-server openssh-clients java-1.8.0-openjdk-devel supervisor mariadb-server  python python-setuptools
RUN sed -i "s/\(^%wheel\)/#\1/g" /etc/sudoers   && sed -i "s/\(^# \)\(%wheel.*NOPASS.*$\)/\2/g" /etc/sudoers

ENV ZOOKEEPER_HOME=/usr/local/zookeeper
ENV ZOOKEEPER_MIRROR_DOWNLOAD=http://mirror.apache-kr.org/zookeeper/zookeeper-3.4.14/zookeeper-3.4.14.tar.gz
ENV ZOOKEEPER_VERSION=3.4.14
ENV APACHE_MIRROR=mirror.apache-kr.org

RUN curl -s ${ZOOKEEPER_MIRROR_DOWNLOAD} | tar -xz -C /usr/local/ &&     cd /usr/local && ln -s ./zookeeper-${ZOOKEEPER_VERSION} zookeeper &&     cp ${ZOOKEEPER_HOME}/conf/zoo_sample.cfg ${ZOOKEEPER_HOME}/conf/zoo.cfg &&     mkdir -p /usr/local/mysql-backup

ADD ./scripts /usr/local/scripts

ENV DRUID_HOME=/usr/local/druid
# ARG DRUID_DOWNLOAD=https://github.com/metatron-app/metatron-discovery/releases/download/3.2.6/druid-metatron-3.2.6.tar.gz
ARG DRUID_DOWNLOAD=https://sktmetatronkrsouthshared.blob.core.windows.net/metatron-public/discovery-dist/latest/druid-0.9.1-latest-hadoop-2.7.3-bin.tar.gz

RUN wget -qO- ${DRUID_DOWNLOAD} | tar xvz -C /usr/local/ && DRUID_PACKAGE_PATH=$(find /usr/local -maxdepth 1 -name "druid*") && ln -s ${DRUID_PACKAGE_PATH} ${DRUID_HOME} && echo -e "#/bin/bash\nexport HADOOP_VERSION=$(find /usr/local/druid/hadoop-dependencies/hadoop-client -maxdepth 1 -printf '%P')" > /etc/profile.d/druid.sh

ENV DISCOVERY_HOME=/usr/local/metatron-discovery
ENV METATRON_DB_TYPE=mysql
#ARG DISCOVERY_DOWNLOAD=https://sktmetatronkrsouthshared.blob.core.windows.net/metatron-public/discovery-dist/latest/metatron-discovery-latest-bin.tar.gz
ADD metatron-discovery-3.3.0-rc3-bin.tar.gz /usr/local/
#RUN wget -qO- ${DISCOVERY_DOWNLOAD} | tar xvz -C /usr/local/ && \
RUN  DISCOVERY_PACKAGE_PATH=$(find /usr/local -maxdepth 1 -name "metatron-discovery*") && \
    ln -s ${DISCOVERY_PACKAGE_PATH} ${DISCOVERY_HOME}

VOLUME /usr/local/mysql-backup
VOLUME /usr/local/druid-backup
VOLUME /usr/local/druid/logs
VOLUME /usr/local/druid/tmp
#VOLUME /usr/local/druid/var
VOLUME /usr/local/metatron-discovery/logs

EXPOSE 8180
EXPOSE 8091
EXPOSE 8090
EXPOSE 8083
EXPOSE 8082
EXPOSE 8081
EXPOSE 3306
EXPOSE 2181

ENTRYPOINT ["/usr/local/scripts/init-service.sh"]