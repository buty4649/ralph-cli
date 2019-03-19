module Ralph::CLI::Commands
  class Post < Base
    class << self
      attr_accessor :path
      attr_accessor :required_parameters
    end
    def path
      self.class.path
    end
    def path=(v)
      self.class.path = v
    end

    def required_parameters
      self.class.required_parameters
    end

    def required_parameters=(v)
      self.class.required_parameters = v
    end

    def call(**options)
      client = gen_client

      if file = options[:file]
        json = File.open(file) {|io| JSON.load(io.read) }
        [json].flatten.each do |item|
          puts JSON.dump(client.post(path, item).body)
        end
      else
        required_parameters&.each do |p|
          if options[p].nil?
            puts "Error: #{p} is required."
            exit 1
          end
        end
        puts JSON.dump(client.post(path, options).body)
      end
    end
  end
end
