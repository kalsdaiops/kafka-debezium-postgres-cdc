# Start with a base image with Java support for Kafka and Debezium
FROM openjdk:11-jre-slim

# Set environment variables for Kafka and Debezium (replace with your versions if needed)
ENV KAFKA_VERSION 2.8.0
ENV DEBEZIUM_VERSION 2.5

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    unzip \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Install Kafka
RUN wget https://archive.apache.org/dist/kafka/$KAFKA_VERSION/kafka_2.13-$KAFKA_VERSION.tgz
RUN tar -xvf kafka_2.13-$KAFKA_VERSION.tgz -C /opt/
RUN ln -s /opt/kafka_2.13-$KAFKA_VERSION /opt/kafka

# Install Debezium Connector
RUN wget https://github.com/debezium/debezium/releases/download/$DEBEZIUM_VERSION/debezium-connector-postgresql-$DEBEZIUM_VERSION-plugin.tar.gz
RUN tar -xvf debezium-connector-postgresql-$DEBEZIUM_VERSION-plugin.tar.gz -C /opt/kafka/plugins/

# Set working directory
WORKDIR /opt/kafka

# Expose necessary ports
EXPOSE 9092
EXPOSE 8083
EXPOSE 2181

# Start Kafka when the container runs
CMD ["bin/kafka-server-start.sh", "config/server.properties"]
