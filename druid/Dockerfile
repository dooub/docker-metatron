FROM openjdk:8u181-jdk

ENV DRUID_VERSION druid-0.9.1-SNAPSHOT.201907251104-hadoop-2.7.3
RUN curl -o /druid-0.9.1-latest-hadoop-2.7.3-bin.tar.gz https://sktmetatronkrsouthshared.blob.core.windows.net/metatron-public/discovery-dist/latest/druid-0.9.1-latest-hadoop-2.7.3-bin.tar.gz
RUN tar xvfp /druid-0.9.1-latest-hadoop-2.7.3-bin.tar.gz
#ADD druid-0.9.1-latest-hadoop-2.7.3-bin.tar.gz /
RUN ln -sf /${DRUID_VERSION} /druid
ADD start-single-foreground.sh /druid
RUN rm -rf /druid/conf/
COPY conf_origin /druid/

# Add Tini
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]
WORKDIR "/druid"
# Run your program under Tini
CMD ["./start-single-foreground.sh", "zookeeper", "router", "coordinator", "broker", "historical", "middleManager", "overlord"]
