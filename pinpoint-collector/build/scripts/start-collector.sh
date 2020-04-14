#!/bin/bash
set -e
set -x

sed -i "/cluster.enable=/ s/=.*/=${CLUSTER_ENABLE}/" /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/pinpoint-collector.properties
sed -i "/cluster.zookeeper.address=/ s/=.*/=${CLUSTER_ZOOKEEPER_ADDRESS}/g" /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/pinpoint-collector.properties
sed -i "/flink.cluster.enable=/ s/=.*/=${FLINK_CLUSTER_ENABLE}/" /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/pinpoint-collector.properties
sed -i "/flink.cluster.zookeeper.address=/ s/=.*/=${FLINK_CLUSTER_ZOOKEEPER_ADDRESS}/" /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/pinpoint-collector.properties

sed -i "/hbase.client.host=/ s/=.*/=${HBASE_HOST}/" /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/profiles/${SPRING_PROFILES}/hbase-env.properties
sed -i "/hbase.client.port=/ s/=.*/=${HBASE_PORT}/" /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/profiles/${SPRING_PROFILES}/hbase-env.properties

# Added this in to use TCP instead of UDP for collector
sed -i "/collector.receiver.stat.tcp=/ s/=.*/=true/" /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/pinpoint-collector.properties
sed -i "/collector.receiver.stat.udp=/ s/=.*/=false/" /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/pinpoint-collector.properties
sed -i "/collector.receiver.span.udp=/ s/=.*/=false/" /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/pinpoint-collector.properties
sed -i "/collector.receiver.span.tcp=/ s/=.*/=true/" /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/pinpoint-collector.properties

sed -i "/level value=/ s/=.*/=\"${DEBUG_LEVEL}\"\/>/g" /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/profiles/${SPRING_PROFILES}/log4j.xml

exec /usr/local/tomcat/bin/catalina.sh run