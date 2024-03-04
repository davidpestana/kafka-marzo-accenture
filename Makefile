bootstrap-server = broker1:9092

start:
	docker compose up -d 
stop:
	docker compose down --remove-orphans

client:
	docker compose -f operations.yaml run --rm client

node:
	docker compose -f operations.yaml run --rm node

topic-create:	
	@read -p "Enter a topic name: " topic; \
	read -p "Enter partition number: " partitions; \
	read -p "Enter replication factor: " replication; \
	docker compose -f operations.yaml run --rm client bash -c \
		"./kafka-topics.sh --create --bootstrap-server $(bootstrap-server) --topic $$topic --partitions $$partitions --replication-factor $$replication"

topic-describe:
	@read -p "Enter a topic name: " topic; \
	docker compose -f operations.yaml run --rm client bash -c \
		"./kafka-topics.sh --describe --bootstrap-server $(bootstrap-server) --topic $$topic"

topic-list:
	docker compose -f operations.yaml run --rm client bash -c \
		"./kafka-topics.sh --list --bootstrap-server $(bootstrap-server)"



console-producer:
	@read -p "Enter a topic name: " topic; \
	docker compose -f operations.yaml run --rm client bash -c \
		"./kafka-console-producer.sh --bootstrap-server $(bootstrap-server) --topic $$topic"

console-consumer:
	@read -p "Enter a topic name: " topic; \
	read -p "Enter a group name: " group; \
	docker compose -f operations.yaml run --rm client bash -c \
		"./kafka-console-consumer.sh --bootstrap-server $(bootstrap-server) --topic $$topic  --group $$group"

group-list:
	docker compose -f operations.yaml run --rm client bash -c \
		"./kafka-consumer-groups.sh --bootstrap-server $(bootstrap-server) --list"

group-describe:
	@read -p "Enter a group name: " group; \
	docker compose -f operations.yaml run --rm client bash -c \
		"./kafka-consumer-groups.sh --bootstrap-server $(bootstrap-server) --describe --group $$group"