"""
We've successfully set up Kafka Connect with Debezium to capture real-time changes from a PostgreSQL database and stream them into Kafka topics. Here’s a step-by-step breakdown:

Verified Data Flow
We confirmed that data changes in PostgreSQL are correctly appearing in Kafka by:

Creating the users table (id, name, email).
Inserting a new row → Kafka received a "op": "c" (CREATE) event.
Updating an existing row → Kafka received a "op": "u" (UPDATE) event.
Deleting a row → Kafka received a "op": "d" (DELETE) event.
"""


from confluent_kafka import Consumer

config = {
    "bootstrap.servers": "localhost:9092",
    "group.id": "my-consumer-group",
    "auto.offset.reset": "earliest"
}

consumer = Consumer(config)
consumer.subscribe(["postgres.public.users"])

while True:
    msg = consumer.poll(1.0)
    if msg is not None and not msg.error():
        print(f"Received message: {msg.value().decode('utf-8')}")
