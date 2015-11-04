# hubot-rabbitmq

Get stats from your RabbitMQ instance.

See [`src/rabbitmq.coffee`](src/rabbitmq.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install hubot-rabbitmq --save`

Then add **hubot-rabbitmq** to your `external-scripts.json`:

```json
["hubot-pingpong"]
```
Also make sure to add:
 **HUBOT_RABBITMQ_URL**
 **HUBOT_RABBITMQ_PORT**
 **HUBOT_RABBITMQ_USER**
 **HUBOT_RABBITMQ_PASS**

 as an env variables on startup

## Sample Interaction

```
user>> hubot rabbitmq stats
```
