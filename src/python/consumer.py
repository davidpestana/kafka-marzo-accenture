from kafka import KafkaConsumer
from kafka import TopicPartition
consumer = KafkaConsumer(bootstrap_servers='broker1:9092')
consumer.assign([TopicPartition('foobar', 0)])
for msg in consumer:
    print (msg)