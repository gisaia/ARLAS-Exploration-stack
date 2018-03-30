FROM ubuntu:17.10

ENV logstash_version=5.6.4

RUN export logstash_archive="logstash-$logstash_version.tar.gz" && \
    apt update && \
    apt -y install curl openjdk-8-jre-headless && \
    curl -o "$logstash_archive" "https://artifacts.elastic.co/downloads/logstash/$logstash_archive" && \
    tar xf "$logstash_archive" && \
    rm -fr "$logstash_archive"

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

ADD content/csv2es.logstash.conf content/mapping.json content/start.bash content/data/aisdk_20180102_head100000.csv content/wui/config.json content/wui/config.map.json  ./

CMD ./start.bash
