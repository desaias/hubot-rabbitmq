# hubot-rabbitmq

Get stats from your RabbitMQ instance.

See [`src/hubot-rabbitmq.coffee`](src/hubot-rabbitmq.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install hubot-rabbitmq --save`

Then add **hubot-rabbitmq** to your `external-scripts.json`:

```json
["hubot-rabbitmq"]
```

**Also make sure to add the following environment variables:**

 * HUBOT_RABBITMQ_DOMAIN (**don't include http://**)
 * HUBOT_RABBITMQ_PORT
 * HUBOT_RABBITMQ_USER
 * HUBOT_RABBITMQ_PASS


## Sample Interaction

```
user>> hubot rabbitmq stats
```
