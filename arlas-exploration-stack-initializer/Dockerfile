FROM ubuntu:17.10

ENV logstash_version=6.2.3

RUN export logstash_archive="logstash-$logstash_version.tar.gz" && \
    apt update && \
    apt -y install curl jq openjdk-8-jre-headless && \
    curl -o "$logstash_archive" "https://artifacts.elastic.co/downloads/logstash/$logstash_archive" && \
    tar xf "$logstash_archive" && \
    rm -fr "$logstash_archive" && \
    "./logstash-$logstash_version/bin/logstash-plugin" install logstash-filter-uuid

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

ADD base.bash /

CMD /base.bash
