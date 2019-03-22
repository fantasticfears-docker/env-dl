# NAME:     fantasticfears/data-platform
# VERSION:  0.1.0
FROM fantasticfears/data-base:0.1

MAINTAINER Erick Guan <fantasticfears@gmail.com>

WORKDIR /

# Install Spark
ARG SPARK_VERION=2.4.0
RUN curl -OL http://apache.mirrors.spacedump.net/spark/spark-${SPARK_VERION}/spark-${SPARK_VERION}-bin-hadoop2.7.tgz && \
    tar -xf spark-${SPARK_VERION}-bin-hadoop2.7.tgz && \
    rm -rf spark-${SPARK_VERION}-bin-hadoop2.7.tgz && \
    mv /spark-${SPARK_VERION}-bin-hadoop2.7 /spark && \
    /etc/service/spark

COPY spark-env.sh /spark/conf/spark-env.sh
COPY run_spark.sh /etc/service/spark/run

RUN chmod +x /etc/service/spark/run

EXPOSE 8080 8081
