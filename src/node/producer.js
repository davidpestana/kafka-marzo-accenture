const { Kafka } = require('kafkajs')

const kafka = new Kafka({
  clientId: 'my-app',
  brokers: ['broker1:9092', 'broker2:9092', 'broker3:9092'],
})



const producer = kafka.producer()
let counter = 0;


send = async () => {
    counter++;
    await producer.connect()
    await producer.send({
    topic: 'foobar',
    messages: [
        
        {ack:0, value: 'Hello KafkaJS user!  ' + counter },
    ],
    })

    await producer.disconnect()    
} 


setInterval(send, 100);