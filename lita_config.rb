Lita.configure do |config|
  # The name your robot will use.
  config.robot.name = "Lita"

  # The locale code for the language to use.
  # config.robot.locale = :en

  # The severity of messages to log. Options are:
  # :debug, :info, :warn, :error, :fatal
  # Messages at the selected level and above will be logged.
  config.robot.log_level = ENV.fetch('LOG_LEVEL', 'info').to_sym

  # An array of user IDs that are considered administrators. These users
  # the ability to add and remove other users from authorization groups.
  # What is considered a user ID will change depending on which adapter you use.
  # config.robot.admins = ["1", "2"]

  # The adapter you want to connect with. Make sure you've added the
  # appropriate gem to the Gemfile.
  config.robot.adapter = :shell

  ## Example: Set options for the chosen adapter.
  # config.adapter.username = "myname"
  # config.adapter.password = "secret"

  ## Example: Set options for the Redis connection.
  # config.redis.host = "127.0.0.1"
  # config.redis.port = 1234
module Lita
  module Handlers
    class Doubler < Handler
      # insert handler code here
      route(
        /^double\s+(\d+)$/i,
        :respond_with_double,
        command:true,
        help:{'double N'=>'prints N + N'}
        )
        def respond_with_double(response)
          #Read up on the Ruby MatchData class for more options
          n=response.match_data.captures.first
          n=Integer(n)

          response.reply "#{n}+#{n}=#{double_number n}"
        end
        def double_number(n)
          n+n
        end
      Lita.register_handler(self)
    end
  end
end



if ENV['RACK_ENV']=='production'
  config.robot.adapter = :slack
  config.redis[:url]=ENV.fetch('REDIS_URL')
  #config.redis[:url]=ENV.fetch('redis://h:p3b0367716aca36ce25b1779241754684109aa4421e23845e1ad85c3f6d203b13@ec2-23-21-82-81.compute-1.amazonaws.com:11959')
else
  config.robot.adapter=:shell
end
#slack adapter demands a value even in dev when we aren't using it..
config.adapters.slack.token=ENV.fetch('SLACK_TOKEN','')
  ## Example: Set configuration for any loaded handlers. See the handler's
  ## documentation for options.
  # config.handlers.some_handler.some_config_key = "value"

  

end
Lita.configure do |config|
  config.robot.adapter = :slack
  config.adapters.slack.token = "xoxb-1447072035412-1446112783174-9L8eeELMZuXIlZaakNTmjWHP"
end