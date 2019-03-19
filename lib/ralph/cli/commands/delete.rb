module Ralph::CLI::Commands
  class Delete < Base
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
      if id = options[:id]
        puts JSON.dump(client.delete("#{path}#{id}/").body)
      end
    end
  end
end
