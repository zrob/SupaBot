module Supabot
  class BaseBotlet
    include Botlet

    GREETING_RESPONSES = [
      "Hi to you too %s!!!",
      "Why hello there %s",
      "OMG HAI %s!!!"
    ].freeze

    def load
      @robot.respond /time$/i do |response|
        response.send "Server time is: #{Time.now}"
      end

      @robot.respond /die$/i do |response|
        response.send "Peace out homeys"
        EM.next_tick { exit }
      end

      @robot.hear /^(hello|hi|hey)( .*#{@robot.name})/i do |response|
        resp = GREETING_RESPONSES.sample % [response.message.user]
        response.send resp
      end

      @robot.respond /make me a pie/i do |response|
        response.send "Yes dear. Your office mom can't wait to bake for you!"
      end
    end
  end
end