require "io/console"
require "readline"

module Ralph::CLI::Commands
  class Token < Base
    desc "Generate API Token"
    argument :username, type: :string, required: true
    def call(username:, **)
      password = STDIN.noecho { Readline.readline("Password: ").tap { puts } }

      client = gen_client
      req = client.post("/api-token-auth/",{username:username, password:password}).body

      if token = req["token"]
        puts token
      else
        code, msg = req.to_a.first
        puts "Error(#{code}): #{msg}"
      end
    end
  end
end
