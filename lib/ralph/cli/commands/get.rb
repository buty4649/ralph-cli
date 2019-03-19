module Ralph::CLI::Commands
  class Get < Base
    class << self
      attr_accessor :path
    end
    def path
      self.class.path
    end
    def path=(v)
      self.class.path = v
    end

    def call(**options)
      client = gen_client
      puts JSON.dump(client.get(path, options).body)
    end
  end
end
