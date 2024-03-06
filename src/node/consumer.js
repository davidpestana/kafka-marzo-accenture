const { Kafka } = require('kafkajs')

const kafka = new Kafka({
  clientId: 'my-app',
  brokers: ['broker1:9092', 'broker2:9092', 'broker3:9092'],
})

const consumer = kafka.consumer({ groupId: 'prueba' })


read = async () => {
    await consumer.connect()
    await consumer.subscribe({ topic: 'foobar', fromBeginning: true })

    await consumer.run({
    eachMessage: async ({ topic, partition, message }) => {
        console.log({
        value: message.value.toString(),
        })
    },
    })   
}

read();