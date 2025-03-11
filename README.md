# kafka-debezium-postgres-docker
# Kafka + Debezium + PostgreSQL CDC

Overview

This project demonstrates Change Data Capture (CDC) using PostgreSQL, Kafka, and Debezium. It captures database changes in real-time and streams them to Kafka topics.

Technologies Used

PostgreSQL - Database

Kafka - Event streaming platform

Zookeeper - Manages Kafka brokers

Debezium - Change Data Capture (CDC)

Kafka Connect - Handles data integration

Docker Compose - Container orchestration

Setup and Running the Project

Prerequisites

Ensure you have Docker and Docker Compose installed.

Steps

Clone the repository:

git clone https://github.com/your-repo/kafka-debezium-postgres.git
cd kafka-debezium-postgres

Start the services:

docker-compose up -d

Register the Debezium Connector:

curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" \
--data @config/debezium-connector.json \
http://localhost:8083/connectors

Verify Data Flow:

docker exec -it kafka kafka-console-consumer --bootstrap-server kafka:9092 --topic postgres.public.users --from-beginning

Expected Behavior

Any INSERT, UPDATE, or DELETE in public.users will be published to Kafka.

The consumer can listen to the topic and process changes in real-time.

Cleanup

To stop and remove containers:

docker-compose down

License

MIT

