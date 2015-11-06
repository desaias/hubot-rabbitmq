# Description
#   Gets stats from your RabbitMQ instance
#
# Configuration:
#   HUBOT_RABBITMQ_DOMAIN  (ie: "www.domain.com")
#   HUBOT_RABBITMQ_PORT (ie: 15672)
#   HUBOT_RABBITMQ_USER (default: guest)
#   HUBOT_RABBITMQ_PASS (default: guest)
#
# Commands:
#   hubot rabbitmq message stats
#   hubot rabbitmq queue stats
#
# Notes:
#   This makes requests to the RabbitMQ Management plugin api, so if you don't hvae that enabled,
#   this probably won't work.
#
# Author:
#   desaias

module.exports = (robot) ->
  
  domain = process.env.HUBOT_RABBITMQ_DOMAIN
  port = process.env.HUBOT_RABBITMQ_PORT
  user = process.env.HUBOT_RABBITMQ_USER
  pass = process.env.HUBOT_RABBITMQ_PASS

  robot.respond /rabbitmq message stats/i, (msg) ->
    robot.http("http://#{user}:#{pass}@#{domain}:#{port}/api/overview?columns=message_stats")
      .get() (err, res, body) ->
        switch res.statusCode
          when 404
            msg.send "Sorry, can't catch the rabbit right now, he's hiding in the magician's hat..."
          when 401
            msg.send "You need to authenticate by setting the HUBOT_RABBITMQ_USER & HUBOT_RABBITMQ_PASS environment variables"
          when 200
            try
              json = JSON.parse(body)
              json = json.message_stats
              msg.send "RabbitMQ Message Stats:\n
                published: #{json.publish}\n
                published rate: #{json.publish_details.rate}\n
                deliver_get: #{json.deliver_get}\n
                deliver_get rate: #{json.deliver_get_details.rate}\n
                confirm: #{json.confirm}\n
                confirm rate: #{json.confirm_details.rate}\n
                redeliver: #{json.redeliver}\n
                redeliver rate: #{json.redeliver_details.rate}\n
                get: #{json.get}\n
                get rate: #{json.get_details.rate}\n
                get_no_ack: #{json.get_no_ack}\n
                get_no_ack rate: #{json.get_no_ack_details.rate}\n"
            catch error
              msg.send "Something went wrong parsing data"
          else
            msg.send "Unable to process your request and we aren't sure what went wrong."

  robot.respond /rabbitmq queue stats/i, (msg) ->
    robot.http("http://#{user}:#{pass}@#{domain}:#{port}/api/overview?columns=queue_totals")
      .get() (err, res, body) ->
        switch res.statusCode
          when 404
            msg.send "Sorry, can't catch the rabbit right now, he's hiding in the magician's hat..."
          when 401
            msg.send "You need to authenticate by setting the HUBOT_RABBITMQ_USER & HUBOT_RABBITMQ_PASS environment variables"
          when 200
            try
              json = JSON.parse(body)
              json = json.queue_totals
              msg.send "RabbitMQ Queue Stats:\n
                messages: #{json.messages}\n
                messages rate: #{json.messages_details.rate}\n
                messages ready: #{json.messages_ready}\n
                messages ready rate: #{json.messages_ready_details.rate}\n
                unacknowledged: #{json.messages_unacknowledged}\n
                unacknowledged rate: #{json.messages_unacknowledged_details.rate}\n
            catch error
              msg.send "Something went wrong parsing data"
          else
            msg.send "Unable to process your request and we aren't sure what went wrong."
