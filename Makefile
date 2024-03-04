bootstrap-server = broker1:9092

start:
	docker compose up -d 
stop:
	docker compose down --remove-orphans

client:
	docker compose -f operations.yaml run --rm client

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

