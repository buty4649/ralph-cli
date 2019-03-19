require 'faraday'
require 'faraday_middleware'

module Ralph::CLI::Commands
  class Base < Hanami::CLI::Command
    def gen_client
      api_url = ENV['RALPH_URL']
      token   = ENV['RALPH_TOKEN']

      Faraday.new(api_url) do |conn|
        conn.request  :json
        conn.response :json, content_type: /\bjson$/
        conn.adapter  Faraday.default_adapter

        if token
          conn.authorization :Token, token
        end
      end
    end
  end
end
