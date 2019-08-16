FROM openjdk:8u181-jdk

#ADD geoserver-metatron-latest.tar.gz /
RUN curl -o /geoserver-metatron-latest.tar.gz https://sktmetatronkrsouthshared.blob.core.windows.net/metatron-public/discovery-dist/latest/geoserver-metatron-latest.tar.gz
ENV GEOSERVER_VERSION "geoserver-metatron-3.1.0"
RUN tar xfp /geoserver-metatron-latest.tar.gz
ENV GEOSERVER_HOME "/geoserver"
ENV GEOSERVER_DATA_DIR "/data"
RUN ln -sf /${GEOSERVER_VERSION} /geoserver && mkdir -p ${GEOSERVER_DATA_DIR}
ADD startup-foreground.sh /geoserver/bin/startup-foreground.sh

# Add Tini
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]
WORKDIR "/geoserver"
# Run your program under Tini
CMD ["./bin/startup-foreground.sh"]
